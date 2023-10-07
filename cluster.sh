#! /usr/bin/env bash

sudo kubeadm init --apiserver-advertise-address $1 --pod-network-cidr 172.16.0.0/12 --kubernetes-version 1.28.0

mkdir -p $HOME/.kube

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/calico.yaml