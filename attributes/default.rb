#
# Cookbook Name:: backupninja
# Recipe:: default
#
# Copyright 2013, lostwebsite.et
#

default["backupninja"]["loglevel"] = 4
default["backupninja"]["reportemail"] = "root"
default["backupninja"]["reportsuccess"] = false
default["backupninja"]["reportwarning"] = true
default["backupninja"]["reportspace"] = true
default["backupninja"]["schedule"] = "everyday at 01:00"


