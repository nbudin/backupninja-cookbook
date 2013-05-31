actions :backup

default_action :backup

attribute :name, :kind_of => String, :name_attribute => true

attribute :encryption_password, :kind_of => String
attribute :includes, :kind_of => Array, :default => ['/var/backups']
attribute :excludes, :kind_of => Array, :default => []
attribute :incremental, :kind_of => String, :default => "yes"

# This is an integer or "yes".
attribute :keep, :kind_of => [Integer, String], :default => 60

attribute :desturl, :kind_of => String
attribute :aws_access_key_id, :kind_of => String
attribute :aws_secret_access_key, :kind_of => String

attribute :bandwidthlimit, :kind_of => Integer, :default => 0
attribute :sshoptions, :kind_of => String