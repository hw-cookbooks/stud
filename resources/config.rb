actions :create, :delete
default_action :create

attribute :path, :kind_of => String
attribute :ssl, :kind_of => [TrueClass,FalseClass], :default => false
attribute :tls, :kind_of => [TrueClass,FalseClass], :default => true
attribute :cipher_suite, :kind_of => String
attribute :engine, :kind_of => String
attribute :backend_port, :kind_of => Numeric, :default => 8000
attribute :frontend_port, :kind_of => Numeric, :default => 8443
attribute :backend_host, :kind_of => String, :default => '127.0.0.1'
attribute :frontend_host, :kind_of => String, :default => '*'
attribute :workers, :kind_of => Numeric, :default => 1
attribute :backlog, :kind_of => Numeric, :default => 100
attribute :keepalive_secs, :kind_of => Numeric
attribute :quiet, :kind_of => [TrueClass,FalseClass], :default => false
attribute :send_to_syslog, :kind_of => [TrueClass,FalseClass], :default => false
attribute :write_ip, :kind_of => [TrueClass,FalseClass], :default => false
attribute :write_proxy, :kind_of => [TrueClass,FalseClass], :default => false
attribute :pemfile_path, :kind_of => String
