#!/bin/bash
# install.sh — Automated Bedrock Server setup

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install unzip screen wget -y

echo "[*] Creating bedrock directory..."
mkdir -p ~/bedrock && cd ~/bedrock

echo "[*] Downloading Bedrock server..."
wget -O bedrock-server.zip https://minecraft.net/en-us/download/server/bedrock
unzip bedrock-server.zip
chmod +x bedrock_server

echo "[*] Setting up swap (1GB)..."
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "[*] Copying default server.properties..."
cp ../server.properties .

echo "[*] Done! Run ./start.sh to launch the server."
