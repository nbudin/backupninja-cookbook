package "rdiff-backup" do
  action :install
end

# Generate an SSH key that can be used to connect from the backed up
# host to another host.
execute "create ssh keypair for backup user" do
  cwd root_dir
  user "root"
  command <<-KEYGEN.gsub(/^ +/, '')
     ssh-keygen -t rsa -f #{backup_ssh_key} -N '' \
      -C 'root@#{node['fqdn']}-#{Time.now.strftime('%FT%T%z')}'
      chmod 0600 #{backup_ssh_key}
      chmod 0644 #{backup_ssh_pub_key}
  KEYGEN
  action :run
  not_if "test -e #{backup_ssh_key}"
end

ruby_block "read ssh key" do
  block do
    File.open(backup_ssh_pub_key, "r") do |keyfile|
      node.set_unless['backupninja']['ssh_key'] = keyfile.read
      node.save
    end
  end
  action :create
end
