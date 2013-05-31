action :backup do

  template "/etc/backup.d/#{new_resource.name}.dup" do
    cookbook "backupninja"
    source "duplicity.conf.erb"
    variables( :encryption_password => new_resource.encryption_password,
               :includes => new_resource.includes,
               :excludes => new_resource.excludes,
               :incremental => new_resource.incremental,
               :keep => new_resource.keep,
               :desturl => new_resource.desturl,
               :aws_access_key_id => new_resource.aws_access_key_id,
               :aws_secret_access_key => new_resource.aws_secret_access_key,
               :bandwidthlimit => new_resource.bandwidthlimit,
               :sshoptions => new_resource.sshoptions)
    mode 0600
    user "root"
    group "root"
    action :create
  end

  new_resource.updated_by_last_action(true)
end
