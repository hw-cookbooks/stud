
# Do our best to force the cleaner to the end of the run list
ruby_block 'stud cleaner notifier' do
  block do
    true
  end
  notifies :run, 'stud_cleaner[cleanup]', :delayed
end

stud_cleaner 'cleanup' do
  action :nothing
  notifies :restart, 'service[stud]'
end
