#!/bin/sh


lock_file="/consul/config/init.log"


function log() {
  printf "%s\n" "$@" >> "$lock_file"
}


function init() {
  bootstrap=$(consul acl bootstrap)
  CONSUL_MGMT_TOKEN=$(printf '%s' "$bootstrap" | awk '/SecretID.*/ {print $2}')
  log "[Consul Bootstrap]:"
  log "${bootstrap}"
  
  consul acl policy create \
    -token="${CONSUL_MGMT_TOKEN}" \
    -name node-policy \
    -rules -<<EOF
agent_prefix "" {
 policy = "write"
}
node_prefix "" {
 policy = "write"
}
service_prefix "" {
 policy = "read"
}
session_prefix "" {
 policy = "read"
}
EOF

  node_token_info=$(consul acl token create \
     -token="${CONSUL_MGMT_TOKEN}" \
     -description "node token" \
     -policy-name node-policy)

  node_token=$(printf '%s' "$node_token_info" | awk '/SecretID.*/ {print $2}')
  consul acl set-agent-token \
     -token="${CONSUL_MGMT_TOKEN}" \
     agent "${node_token}"

  log "[Consul Node Token]:"
  log "${node_token_info}"

  # create valult token

  consul acl policy create \
     -token="${CONSUL_MGMT_TOKEN}" \
     -name vault-policy \
     -rules -<<EOF
key_prefix "vault/" {
 policy = "write"
}
node_prefix "" {
 policy = "write"
}
service "vault" {
 policy = "write"
}
agent_prefix "" {
 policy = "write"
}
session_prefix "" {
 policy = "write"
}
EOF


  vault_token_info=$(consul acl token create \
      -token="${CONSUL_MGMT_TOKEN}" \
      -description "Token for Vault Service" \
      -policy-name vault-policy)


  vault_token=$(printf '%s' "$vault_token_info" | awk '/SecretID.*/ {print $2}')

  sed -i "s#token.*#token = \"$vault_token\"#g" /vault/config/vault.hcl

  log "[Vault Token]:"
  log "${vault_token_info}"
}


if ! test -f "$lock_file"; then
  today=$(date +"%Y-%m-%d")

  log "[Date]: ${today}"

  leader=$(curl -s "$CONSUL_HTTP_ADDR/v1/status/leader")

  while [ ${#leader} -lt 3 ]; do
    echo $leader
    sleep 1
    leader=$(curl -s "$CONSUL_HTTP_ADDR/v1/status/leader")
  done
  
  init
else
  echo "not exec init."
fi
