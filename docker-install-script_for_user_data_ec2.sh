#!/bin/bash

apt-get update

# Install prerequisites
apt-get install -y ca-certificates curl gnupg git

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

systemctl enable docker
systemctl start docker

mkdir -p /home/ubuntu/workspace

cd /home/ubuntu/workspace

git clone https://github.com/morAroesti/foodtrucks.git

chown -R ubuntu:ubuntu /home/ubuntu/workspace

# INSTALL AWS CLI AND UNZIP
cd /home/ubuntu/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

sudo apt install unzip
unzip -u awscliv2.zip
sudo /home/ubuntu/aws/install
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 779846827025.dkr.ecr.ap-south-1.amazonaws.com
cd /home/ubuntu/workspace/foodtrucks
docker compose up
