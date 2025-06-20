#!/bin/bash
set -e
NODE_INDEX=$1
MASTER_IP=$2
MASTER_COUNT=$3

if [ "$NODE_INDEX" -eq 0 ]; then
  echo "[+] Installing K3s master 0 (cluster-init)"
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644" sh -
else
  echo "[+] Waiting for token from master at $MASTER_IP..."
  # retry for up to 3 minutes
  for i in {1..30}; do
    TOKEN=$(ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ubuntu@$MASTER_IP "sudo cat /var/lib/rancher/k3s/server/node-token" 2>/dev/null) && break
    echo "Token not available yet, retrying..."
    sleep 6
  done

  if [ -z "$TOKEN" ]; then
    echo "Failed to get token from master after retries"
    exit 1
  fi

  if [ "$NODE_INDEX" -lt "$MASTER_COUNT" ]; then
    echo "[+] Joining as additional master"
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="server" sh -
  else
    echo "[+] Joining as worker"
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" sh -
  fi
fi
