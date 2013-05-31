#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

package "backupninja" do
  action :install
end

root_dir = node['etc']['passwd']['root']['dir']
backup_ssh_key = "#{root_dir}/.ssh/id_rsa.backup"
backup_ssh_pub_key = "#{root_dir}/.ssh/id_rsa.backup.pub"

template "/etc/backupninja.conf" do
  source "backupninja.conf.erb"
  variables( :loglevel => node["backupninja"]["loglevel"],
             :reportemail => node["backupninja"]["reportemail"],
             :reportsuccess => node["backupninja"]["reportsuccess"] ? "yes" : "no",
             :reportwarning => node["backupninja"]["reportwarning"] ? "yes" : "no",
             :reportspace => node["backupninja"]["reportspace"] ? "yes" : "no",
             :schedule => node["backupninja"]["schedule"] )
end
