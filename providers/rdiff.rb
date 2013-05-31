#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

action :backup do
  
  include_recipe "backupninja::rdiff"

  if new_resource.auto
    backupnode = search(:node, 'run_list:recipe\[backupninja\:\:server\]')    
    desthost = backupnode[0]['fqdn']
    destuser = backupnode[0]['backupninja']['server']['user']
    userhome = node['etc']['passwd']['root']['dir']
    destmode = "remote"
  else
    if new_resource.remote.nil? 
      destmode = "local"
    else
      destmode = "remote"
    end
    desthost = new_resource.remote
    destuser = nil
  end

  known_host backupnode[0]['fqdn']

  template "/etc/backup.d/#{new_resource.name}.rdiff" do
    cookbook "backupninja"
    source "rdiff.conf.erb"
    variables( :directories => new_resource.directories,
               :exclude_directories => new_resource.exclude_directories,
               :keep => new_resource.keep,
               :nicelevel => new_resource.nicelevel,
               :destmode => destmode,
               :desthost => desthost,
               :destuser => destuser,
               :userhome => userhome,
               :destdir => new_resource.directory )
    mode 0600
    user "root"
    group "root"
    action :create
  end

  new_resource.updated_by_last_action(true)
end
