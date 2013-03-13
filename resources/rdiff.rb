actions :backup

default_action :backup

attribute :name, :kind_of => String, :name_attribute => true

attribute :directories, :kind_of => Array
attribute :exclude_directories, :kind_of => Array, :default => []

# This is an integer or "yes".
attribute :keep, :kind_of => [Integer, String], :default => 60

attribute :nicelevel, :kind_of => [Integer], :default => 0

attribute :remote, :kind_of => String, :default => nil
attribute :directory, :kind_of => String

# Automatically find a backup host.
attribute :auto, :kind_of => [TrueClass, FalseClass], :default => false
