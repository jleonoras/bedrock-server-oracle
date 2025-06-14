#!/bin/bash
# install.sh — Automated Bedrock Server setup for Oracle Cloud

set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install unzip screen wget -y

BEDROCK_DIR="../bedrock"
mkdir -p "$BEDROCK_DIR"
cd "$BEDROCK_DIR"

# Only download if not already present (for users who uploaded via SCP)
if [ ! -f "bedrock-server.zip" ]; then
  echo "[*] Downloading Minecraft Bedrock server..."
  wget -O bedrock-server.zip https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.84.1.zip
else
  echo "[*] bedrock-server.zip already exists, skipping download."
fi

echo "[*] Extracting server files..."
unzip -o bedrock-server.zip
chmod +x bedrock_server

echo "[*] Setting up 1GB swap file..."
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
grep -q '/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "[*] Copying server.properties..."
cp ../bedrock-server-oracle/server.properties .

echo "[✓] Setup complete! To start the server, run:"
echo "cd ../bedrock && ./start.sh"
