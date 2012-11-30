
case node[:stud][:install_method]
when 'package'
  include_recipe 'stud::package'
when 'source'
  include_recipe 'stud::source'
else
  raise 'Unknown installation method provided for stud'
end

directory node[:stud][:conf_dir] do
  recursive true
  mode 0755
end

if(node[:stud][:write_default_config])
  include_recipe 'stud::config'
end

service 'stud' do
  action [:enable, :start]
end
