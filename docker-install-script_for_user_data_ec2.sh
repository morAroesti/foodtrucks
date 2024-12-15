#!/bin/bash

apt-get update

# Install prerequisites
apt-get install -y ca-certificates curl gnupg

# Create directory for keyrings
install -m 0755 -d /etc/apt/keyrings

# Download and install Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add ubuntu user to docker group to run docker without sudo
usermod -aG docker ubuntu

# Enable and start Docker service
systemctl enable docker
systemctl start docker

# Optional: Verify Docker installation
docker --version


# INSTALL GIT 
apt-get install -y git
git --version
git config --global user.name "Mor Aroesti"
git config --global user.email "mor.aroesti@gmail.com"
