#! /usr/bin/env bash

HOST_NETWORK_ADDRESS=$(hostname -i)
HOST_PRIVATE_ADDRESS=$(hostname -I | awk '{print $2}')

sudo sed -i "s/$HOST_NETWORK_ADDRESS/$HOST_PRIVATE_ADDRESS/g" /etc/hosts

cat <<EOF | sudo tee -a /etc/hosts
$1 $2
$3 $4
EOF