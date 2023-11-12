#! /usr/bin/env bash

if [[ $# -ne 1 ]]; then
  echo "$script_error: Expecting 1 argument to be provided: email"
  exit 1
fi

ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519 -q -P ""

eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519