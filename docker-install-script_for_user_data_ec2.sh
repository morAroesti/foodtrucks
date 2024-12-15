#!/bin/bash

sudo apt-get update

# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg

# Create directory for keyrings
install -m 0755 -d /etc/apt/keyrings

# Download and install Docker's official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Set up the repository
sudo echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null


sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add ubuntu user to docker group to run docker without sudo
usermod -aG docker ubuntu

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Optional: Verify Docker installation
docker --version


# INSTALL GIT | CONFIG GIT | CLONE SOURCE CODE
sudo apt-get install -y git
git --version
sudo git config --global user.name "Mor Aroesti"
sudo git config --global user.email "mor.aroesti@gmail.com"
sudo mkdir ~/workspace
cd ~/workspace
sudo git clone https://github.com/morAroesti/foodtrucks.git
