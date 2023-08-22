#!/bin/bash

# please run via sudor (sudo -i)

# Install kubeadm
apt-get update && \
apt-get install -y apt-transport-https curl ca-certificates && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF && \
apt-get update && \



# && \
# curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
# echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
# apt-get update && \
# apt-get install -y kubelet kubeadm kubectl && \
# apt-mark hold kubelet kubeadm kubectl

