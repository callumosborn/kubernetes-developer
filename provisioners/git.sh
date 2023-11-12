#! /usr/bin/env bash

full_name=$(echo $1 | tr '-' ' ')
email_address=$2

git config --global user.name $full_name
git config --global user.email $email_address
git config --global init.defaultBranch master