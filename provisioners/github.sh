#! /usr/bin/env bash

if [[ $# -ne 2 ]]; then
  echo "$script_error: Expecting 2 arguments to be provided: title and token"
  exit 1
fi

title=$1
token=$2

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

sudo apt-get update
sudo apt-get install gh -y

cat <<< $token | gh auth login --git-protocol ssh --with-token

gh ssh-key add ~/.ssh/id_ed25519.pub --title $title

ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts

ssh -T git@github.com &> /dev/null

if [[ $? -ne 1 ]]; then
  echo "$script_error: SSH connection cannot be established to github.com"
  exit 2
fi
