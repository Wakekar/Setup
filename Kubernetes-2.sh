#!/bin/bash

echo "Starting Kubernetes Control Plane Initialization..."

# Enable kubelet
systemctl enable --now kubelet

# Initialize cluster
kubeadm init --pod-network-cidr=10.244.0.0/16

# Configure kubectl for root user
mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel CNI
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

# Wait a few seconds
sleep 20

# Show node status
kubectl get nodes

echo "Kubernetes setup completed."
