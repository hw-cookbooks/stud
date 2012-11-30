#
# Cookbook Name:: stud
# Recipe:: default
#
# Copyright 2012, Robby Grossman
#
# MIT Licensed, or any other license you want
#

include_recipe "build-essential"

package "openssl"
package "libssl-dev"
package "libev-dev"
package "git-core"

git "#{node[:stud][:source][:install_prefix_root]}/share/stud" do
  repository "git://github.com/bumptech/stud.git"
  reference node[:stud][:source][:version]
  action :sync
end

user node[:stud][:user] do
  action :create
  system true
  home node[:stud][:options][:chroot_path] if node[:stud][:options][:chroot_path]
  shell '/bin/false'
end

if(node[:stud][:options][:chroot_path])
  directory node[:stud][:options][:chroot_path] do
    action :create
    mode 0755
    owner node[:stud][:user]
    recursive true
  end
end

directory node[:stud][:source][:pid_dir] do
  mode 0755
  recursive true
end

execute "build-stud" do
  user node[:stud][:user]
  cwd "#{node[:stud][:source][:install_prefix_root]}/share/stud"
  command "make && make install"
  action :run
end

# Link the binary to the one we built
link "#{node[:stud][:source][:install_prefix_root]}/bin/stud" do
  to "#{node[:stud][:source][:install_prefix_root]}/share/stud/stud"
  action :create
end

template '/etc/init.d/stud' do
  source 'stud_init.erb'
  mode 0755
end
