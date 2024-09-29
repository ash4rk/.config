#!/bin/bash

echo -e "SSH configuration."
read -p "Enter your user.name: " username
read -p "Enter your user.email: " email

git config --global user.name $username
git config --global user.email $email

# ssh-keygen -t ed25519 -C $email
