#!/bin/bash
set -e

NODE_INDEX=$1
MASTER_IP=$2
MASTER_COUNT=$3

echo "[+] Node index: $NODE_INDEX | Master IP: $MASTER_IP | Master count: $MASTER_COUNT"

if [ "$NODE_INDEX" -eq 0 ]; then
  echo "[+] Installing K3s primary master (init)"
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644" sh -
else
  echo "[+] Waiting for token from primary master..."
  MAX_RETRIES=20
  RETRY_DELAY=5
  TOKEN=""

  for i in $(seq 1 $MAX_RETRIES); do
    TOKEN=$(ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ubuntu@$MASTER_IP "sudo cat /var/lib/rancher/k3s/server/node-token" 2>/dev/null) && break
    echo "[$i/$MAX_RETRIES] Token not available yet, retrying in $RETRY_DELAY seconds..."
    sleep $RETRY_DELAY
    RETRY_DELAY=$((RETRY_DELAY + 5))  # exponential backoff
  done

  if [ -z "$TOKEN" ]; then
    echo "[!] Failed to retrieve K3s token after multiple retries"
    exit 1
  fi

  if [ "$NODE_INDEX" -lt "$MASTER_COUNT" ]; then
    echo "[+] Joining as secondary master"
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="server" sh -
  else
    echo "[+] Joining as worker node"
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" sh -
  fi
fi
