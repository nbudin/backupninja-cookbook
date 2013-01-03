#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

action :backup do

  template "/etc/backup.d/#{new_resource.name}.mysql" do
    cookbook "backupninja"
    source "mysql.conf.erb"
    variables( :databases => new_resource.databases,
               :backupdir => new_resource.backupdir,
               :user => new_resource.user,
               :password => new_resource.password )
    mode 0600
    user "root"
    group "root"
    action :create
  end

  new_resource.updated_by_last_action(true)
end
