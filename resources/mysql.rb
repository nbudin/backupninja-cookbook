actions :backup

default_action :backup

attribute :name, :kind_of => String, :name_attribute => true

attribute :databases, :kind_of => Array, :default => ["All"]
attribute :backupdir, :kind_of => String, :default => "/var/backups/mysql"

attribute :user, :kind_of => String
attribute :password, :kind_of => String
