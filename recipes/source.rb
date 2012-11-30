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

git "#{node[:stud][:install_prefix_root]}/share/stud" do
  repository "git://github.com/bumptech/stud.git"
  reference node[:stud][:source][:version]
  action :sync
end

execute "build-stud" do
  user node[:stud][:user]
  cwd "#{node[:stud][:install_prefix_root]}/share/stud"
  command "make && make install"
  action :run
end

# Link the binary to the one we built
link "#{node[:stud][:install_prefix_root]}/bin/stud" do
  to "#{node[:stud][:install_prefix_root]}/share/stud/stud"
  action :create
end

