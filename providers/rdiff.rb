#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

action :backup do
  
  if new_resource.remote.nil? 
    destmode = "local"
  else
    destmode = "remote"
  end

  template "/etc/backup.d/#{new_resource.name}.rdiff" do
    cookbook "backupninja"
    source "rdiff.conf.erb"
    variables( :directories => new_resource.directories,
               :exclude_directories => new_resource.exclude_directories,
               :keep => new_resource.keep,
               :nicelevel => new_resource.nicelevel,
               :destmode => destmode,
               :desthost => new_resource.remote,
               :destdir => new_resource.directory )
    mode 0600
    user "root"
    group "root"
    action :create
  end

  new_resource.updated_by_last_action(true)
end
