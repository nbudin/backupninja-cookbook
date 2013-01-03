#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

package "backupninja" do
  action :install
end

package "rdiff-backup" do
  action :install
end

template "/etc/backupninja.conf" do
  source "backupninja.conf.erb"
  variables( :loglevel => node["backupninja"]["loglevel"],
             :reportemail => node["backupninja"]["reportemail"],
             :reportsuccess => node["backupninja"]["reportsuccess"] ? "yes" : "no",
             :reportwarning => node["backupninja"]["reportwarning"] ? "yes" : "no",
             :reportspace => node["backupninja"]["reportspace"] ? "yes" : "no",
             :schedule => node["backupninja"]["schedule"] )
end
