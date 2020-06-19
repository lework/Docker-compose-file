#!/bin/sh


lock_file="/vault/config/init.log"


function log() {
  printf "%s\n" "$@" >> "$lock_file"
}


function init() {
  vault_init_info=$(vault operator init)
  log "[Vault initialized]:"
  log "${vault_init_info}"
  
  # Parse unsealed keys
  vault operator unseal $(printf '%s' "$vault_init_info" | awk '/Unseal Key 1:.*/ {print $4}' )
  vault operator unseal $(printf '%s' "$vault_init_info" | awk '/Unseal Key 2:.*/ {print $4}' )
  vault operator unseal $(printf '%s' "$vault_init_info" | awk '/Unseal Key 3:.*/ {print $4}' )

  # Get root token
  export VAULT_TOKEN=$(printf '%s' "$vault_init_info" | awk '/Initial Root Token:.*/ {print $4}' )

  # Enable kv
  vault secrets enable kv
  
  # Add test value to hello
  vault kv put kv/hello value=world
}


if ! test -f "$lock_file"; then
  today=$(date +"%Y-%m-%d")

  log "[Date]: ${today}"

  until vault status | grep Initialized &>/dev/null; do
    >&2 echo "vault is unavailable - sleeping"
    sleep 1
  done

  init
else
  echo "not exec init."
fi
