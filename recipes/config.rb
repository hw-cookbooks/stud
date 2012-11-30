run_flags = []

run_flags << "--tls" if node[:stud][:options][:tls] && !node[:stud][:options][:ssl]
run_flags << "--ssl" if node[:stud][:options][:ssl]
run_flags << "-c #{node[:stud][:options][:cipher_suite]}" if node[:stud][:options][:cipher_suite]
run_flags << "-e #{node[:stud][:options][:engine]}" if node[:stud][:options][:engine]

run_flags << "-b #{node[:stud][:options][:backend_host]},#{node[:stud][:options][:backend_port]}" if node[:stud][:options][:backend_host] && node[:stud][:options][:backend_port]
run_flags << "-f #{node[:stud][:options][:frontend_host]},#{node[:stud][:options][:frontend_port]}" if node[:stud][:options][:frontend_host] && node[:stud][:options][:frontend_port]

run_flags << "-n #{node[:stud][:options][:workers]}" if node[:stud][:options][:workers]
run_flags << "-B #{node[:stud][:options][:backlog]}" if node[:stud][:options][:backlog]
run_flags << "-k #{node[:stud][:options][:keepalive_secs]}" if node[:stud][:options][:keepalive_secs]

run_flags << "-r #{node[:stud][:chroot_path]}" if node[:stud][:chroot_path]
run_flags << "-u #{node[:stud][:user]}" unless node[:stud][:user] == 'root'

run_flags << "-q" if node[:stud][:options][:quiet]
run_flags << "-s" if node[:stud][:options][:send_to_syslog]

run_flags << "--write-ip" if node[:stud][:options][:write_ip]
run_flags << "--write-proxy" if node[:stud][:options][:write_proxy]

template File.join(node[:stud][:conf_dir], 'default.conf') do
  source 'stud.conf.erb'
  mode 0644
  variables(
    :run_flags => run_flags
  )
end

template '/etc/init.d/stud-default' do
  source 'stud_init_solo.erb'
  mode 0755
  variables(
    :name => 'default'
  )
end

node.run_state[:stud_conf_files] ||= []
node.run_state[:stud_conf_files] << 'default'
