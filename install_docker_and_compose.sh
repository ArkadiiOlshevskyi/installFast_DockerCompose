#!/bin/bash

# --- Docker Installation ---
set -e

echo "Updating packages..."
sudo apt update -y

echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating packages..."
sudo apt update -y

echo "Checking available Docker versions..."
apt-cache policy docker-ce

echo "Installing Docker..."
sudo apt install -y docker-ce

echo "Verifying Docker service status..."
sudo systemctl status docker --no-pager

echo "Adding user to docker group..."
sudo usermod -aG docker ${USER}

echo "Opening docker containers ports to recieve data"
sudo chmod 777 -Rf /var/run/docker.sock

echo "Checking user groups..."
newgrp docker << END
groups
END

# --- Docker Compose Installation ---

echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose

echo "Making docker-compose executable..."
sudo chmod +x /usr/local/bin/docker-compose

echo "Verifying docker-compose version..."
docker-compose --version
