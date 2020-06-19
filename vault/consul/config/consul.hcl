
datacenter = "dc1"
data_dir = "/consul/data"
encrypt = "pW6hefWywYZp+6o0b3IzToYAR/EdX0p0pSF/VRsXoAw="

ui = true
server = true
bootstrap_expect = 1
client_addr = "0.0.0.0"
bind_Addr = "0.0.0.0"

node_name = "node1"

acl {
 enabled = true
 default_policy = "deny"
 enable_token_persistence = true
}
