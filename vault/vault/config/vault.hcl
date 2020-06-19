storage "consul" {
  address = "consul:8500"
  path    = "vault"
  token = "48cdeff7-8624-c0ae-cd0e-bc39bd93e857"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = 1   
}

ui = true
log_level = "info"
