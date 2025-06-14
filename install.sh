#!/bin/bash
# install.sh — Automated Bedrock Server setup for Oracle Cloud (1GB RAM)

set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install unzip screen wget -y

echo "[*] Creating ~/Minecraft folder structure..."
mkdir -p ~/Minecraft/bedrock
cd ~/Minecraft/bedrock

# Dynamically detect the ZIP file in the repo folder
ZIP_FILE=$(ls ../bedrock-server-oracle/bedrock-server-*.zip 2>/dev/null | head -n 1)

if [ ! -f "$ZIP_FILE" ]; then
  echo "[!] No bedrock-server-*.zip found in ../bedrock-server-oracle"
  echo "    Please upload the file using HestiaCP or similar, then download it to:"
  echo "    ~/Minecraft/bedrock-server-oracle/bedrock-server-<version>.zip"
  exit 1
fi

echo "[*] Using Bedrock server archive: $ZIP_FILE"
cp "$ZIP_FILE" bedrock-server.zip

echo "[*] Extracting server..."
unzip -o bedrock-server.zip
chmod +x bedrock_server

echo "[*] Creating 1GB swap file..."
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
grep -q '/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "[*] Enabling server auto-start on reboot..."
(crontab -l 2>/dev/null; echo "@reboot screen -dmS bedrock \$HOME/Minecraft/bedrock/start.sh") | crontab -

echo "[✓] Setup complete!"
echo "Now configure your server with:"
echo "nano ~/Minecraft/bedrock/server.properties"
echo "Then start the server with:"
echo "cd ~/Minecraft/bedrock && ./start.sh"
