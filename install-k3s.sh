#!/bin/bash

NODE_INDEX=$1
MASTER_IP=$2
MASTER_COUNT=$3

if [ "$NODE_INDEX" -eq 0 ]; then
  echo "[+] Installing K3s as first master..."
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644" sh -
else
  echo "[+] Fetching K3s token from primary master..."
  TOKEN=$(ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa ubuntu@$MASTER_IP "sudo cat /var/lib/rancher/k3s/server/node-token")
  
  if [ "$NODE_INDEX" -lt "$MASTER_COUNT" ]; then
    echo "[+] Joining as additional master..."
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" INSTALL_K3S_EXEC="server" sh -
  else
    echo "[+] Joining as worker..."
    curl -sfL https://get.k3s.io | K3S_URL="https://$MASTER_IP:6443" K3S_TOKEN="$TOKEN" sh -
  fi
fi
