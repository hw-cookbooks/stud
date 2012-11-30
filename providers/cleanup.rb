def load_current_resource
  node.run_state[:stud_conf_files] ||= []
end


action :run do
  existing = Dir.new(node[:stud][:conf_dir]).find_all{|f| !f.start_with?('.')}
  to_del = existing - node.run_state[:stud_conf_files]
  if(to_del.size > 0)
    to_del.each do |f|
      file ::File.join(node[:stud][:conf_dir], f) do
        action :delete
      end
    end
    new_resource.updated_by_last_action(true)
  end
end
