#!/bin/bash
# please run via sudor (sudo -i)
# [v] ubuntu 20.04


# Install kubeadm
apt-get update && \
apt-get install -y apt-transport-https curl ca-certificates && \
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF && \
apt-get update && \
apt-get install -y kubelet kubeadm kubectl && \
apt-mark hold kubelet kubeadm kubectl

# Referece: https://velog.io/@simgyuhwan/kubeadm-ubuntu-20.04-%EC%84%A4%EC%B9%98