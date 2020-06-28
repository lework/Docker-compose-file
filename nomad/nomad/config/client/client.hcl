bind_addr = "{{GetInterfaceIP \"ens33\"}}"

# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/nomad/data"

# Enable the client
client {
    enabled = true

    # For demo assume we are talking to server1. For production,
    # this should be like "nomad.service.consul:4647" and a system
    # like Consul used for service discovery.
    servers = ["nomad_s1:4647", "nomad_s2:4647", "nomad_s3:4647"]
}

ports {
    http = 5656
}

consul {
  address = "127.0.0.1:8500"
}
