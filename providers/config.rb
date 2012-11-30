def load_current_resource
  unless(new_resource.path)
    new_resource.path File.join(node[:stud][:conf_dir], new_resource.name)
  end
  node.run_state[:stud_conf_files] ||= []
end

action :create do
  run_flags = []
  run_flags << "--tls" if new_resource.tls && !new_resource.ssl
  run_flags << "--ssl" if new_resource.ssl
  run_flags << "-c #{new_resource.cipher_suite}" if new_resource.cipher_suite
  run_flags << "-e #{new_resource.engine}" if new_resource.engine
  run_flags << "-b #{new_resource.backend_host},#{new_resource.backend_port}" if new_resource.backend_host && new_resource.backend_port
  run_flags << "-f #{new_resource.frontend_host},#{new_resource.frontend_port}" if new_resource.frontend_host && new_resource.frontend_port
  run_flags << "-n #{new_resource.workers}" if new_resource.workers
  run_flags << "-B #{new_resource.backlog}" if new_resource.backlog
  run_flags << "-k #{new_resource.keepalive_secs}" if new_resource.keepalive_secs
  run_flags << "-r #{node[:stud][:chroot_path]}" if node[:stud][:chroot_path]
  run_flags << "-u #{node[:stud][:user]}" unless node[:stud][:user] == 'root'
  run_flags << "-q" if new_resource.quiet
  run_flags << "-s" if new_resource.send_to_syslog
  run_flags << "--write-ip" if new_resource.write_ip
  run_flags << "--write-proxy" if new_resource.write_proxy

  template new_resource.path do
    mode 0644
    variables(
      :run_flags => run_flags,
      :cert => new_resource.pemfile_path
    )
    notifies :restart, 'service[stud]'
    notifies :create, "ruby_block[stud config notifier[#{new_resource.name}]]", :immediately
  end

  ruby_block "stud config notifier[#{new_resource.name}]" do
    block do
      new_resource.updated_by_last_action(true)
    end
    action :nothing
  end
  node.run_state[:stud_conf_files] << File.basename(new_resource.path)
end

action :delete do
  template new_resource.path do
    action :delete
    only_if do
      ::File.exists?(new_resource.path) && new_resource.updated_by_last_action(true)
    end
  end
end
