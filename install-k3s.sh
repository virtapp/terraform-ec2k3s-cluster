#!/bin/bash

NODE_INDEX=$1
MASTER_IP=$2
MASTER_COUNT=$3

if [ "$NODE_INDEX" -eq 0 ]; then
  # First master initializes cluster
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --write-kubeconfig-mode 644" sh -
else
  if [ "$NODE_INDEX" -lt "$MASTER_COUNT" ]; then
    # Other masters join cluster
    curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token) INSTALL_K3S_EXEC="server" sh -
  else
    # Workers join
    curl -sfL https://get.k3s.io | K3S_URL="https://${MASTER_IP}:6443" K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token) sh -
  fi
fi
