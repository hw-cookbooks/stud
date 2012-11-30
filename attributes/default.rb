default[:stud][:install_method] = 'source'
default[:stud][:conf_dir] = '/etc/stud'
default[:stud][:user] = node.platform_family == 'debian' ? '_stud' : 'root'
default[:stud][:pemfile_path] = nil
default[:stud][:write_default_config] = true
# Security options
default[:stud][:chroot_path] = nil

# source options
default[:stud][:source][:version] = '0.3'
default[:stud][:source][:install_prefix_root] = "/usr/local"
default[:stud][:source][:pid_dir] = '/var/run'

# Encryption options
default[:stud][:options][:tls] = true
default[:stud][:options][:ssl] = false
default[:stud][:options][:cipher_suite] = nil
default[:stud][:options][:engine] = nil

# Socket options
default[:stud][:options][:backend_host] = "127.0.0.1"
default[:stud][:options][:backend_port] = "8000"
default[:stud][:options][:frontend_host] = "*"
default[:stud][:options][:frontend_port] = "8443"

# Performance options
default[:stud][:options][:workers] = 1
default[:stud][:options][:backlog] = 100
default[:stud][:options][:keepalive_secs] = nil

# Logging options
default[:stud][:options][:quiet] = false
default[:stud][:options][:send_to_syslog] = false

# Special options
default[:stud][:options][:write_ip] = false
default[:stud][:options][:write_proxy] = false # Set this to true if you're using haproxy
