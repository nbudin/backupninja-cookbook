#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.net
#

# Simple recipe for off-site backups.  Creates an user which will
# receive the backup files. The backup files are put in the backup
# user home.

# Generate a random password for the user
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

node.set_unless['backupninja']['server']['password'] = secure_password

package "rdiff-backup" do
  action :install
end

# Create the user.
user node['backupninja']['server']['user'] do
  password node['backupninja']['server']['password']
  action :modify
end

backupuser = node['backupninja']['server']['user']
backupuser_dir = node['etc']['passwd'][backupuser]['dir']

directory "#{backupuser_dir}/.ssh" do
  action :create
end

ruby_block "write ssh keys" do
  block do
    clientnodes = search(:node, "backupninja_server_ssh_key:*")
    clientnodes.each do |clientnode|
      File.open("#{backupuser_dir}/.ssh/authorized_keys", "a") do |f|
        f.write(clientnode['backupninja']['server']['ssh_key'])
      end
    end
  end
  action :create
end
   
file "#{backupuser_dir}/.ssh/authorized_keys" do
  mode "0600"
  user backupuser
  group backupuser
end
