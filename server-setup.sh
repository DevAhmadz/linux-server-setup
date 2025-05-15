#!/bin/bash

# Exit on error
set -e

echo " Starting Ubuntu Server Setup..."

# Update packages
sudo apt update && sudo apt upgrade -y

# Create a new sudo user
read -p "Enter new username: " username
sudo adduser $username
sudo usermod -aG sudo $username

# Enable UFW firewall
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw --force enable

# Install basic tools
sudo apt install -y curl git fail2ban htop unzip

# Set timezone
sudo timedatectl set-timezone Africa/Lagos

# Install Docker (optional)
read -p "Install Docker? (y/n): " install_docker
if [[ "$install_docker" == "y" ]]; then
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $username
    echo "Docker installed and user added to docker group."
fi

echo "Server setup complete!"

