bind_addr = "{{GetInterfaceIP \"eth0\"}}"

# Increase log verbosity
log_level = "INFO"

# Setup data dir
data_dir = "/nomad/data"

# Enable the server
server {
    enabled = true

    # Self-elect, should be 3 or 5 for production
    bootstrap_expect = 3
    
    server_join {
      retry_join = ["nomad_s1", "nomad_s2", "nomad_s3"]
      retry_max = 3
      retry_interval = "15s"
    }
  
     
    # Encrypt gossip communication
    encrypt = "cg8StVXbQJ0gPvMd9o7yrg=="
}

consul {
  address = "consul_c:8500"
}
