#!/bin/bash
# install.sh — Simple Minecraft Bedrock Server setup for Oracle Cloud (1GB RAM)

set -e

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install unzip screen wget -y

echo "[*] Creating ~/Minecraft folder structure..."
mkdir -p ~/Minecraft/bedrock
cd ~/Minecraft/bedrock

# Find the Bedrock server zip
ZIP_FILE=$(ls ../bedrock-server-oracle/bedrock-server-*.zip 2>/dev/null | head -n 1)

if [ ! -f "$ZIP_FILE" ]; then
  echo "[!] No bedrock-server-*.zip found in ../bedrock-server-oracle"
  echo "    Upload it to: ~/Minecraft/bedrock-server-oracle/bedrock-server-<version>.zip"
  exit 1
fi

echo "[*] Using archive: $ZIP_FILE"
cp "$ZIP_FILE" bedrock-server.zip

echo "[*] Extracting server..."
unzip -o bedrock-server.zip
chmod +x bedrock_server

echo "[*] Creating 1GB swap file..."

# Turn off swap if already active, and remove old file
sudo swapoff /swapfile 2>/dev/null || true
sudo rm -f /swapfile

# Create new swap file
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Ensure it persists after reboot
grep -q '^/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

echo "[*] Installing systemd service..."
SERVICE_PATH="/etc/systemd/system/bedrock.service"
SCREEN_PATH=$(command -v screen)

sudo tee "$SERVICE_PATH" > /dev/null <<EOF
[Unit]
Description=Minecraft Bedrock Server
After=network.target

[Service]
User=$USER
WorkingDirectory=/home/$USER/Minecraft/bedrock
ExecStart=/home/$USER/Minecraft/bedrock-server-oracle/start.sh
ExecStop=$SCREEN_PATH -S bedrock -X quit
Environment=LD_LIBRARY_PATH=/home/$USER/Minecraft/bedrock

[Install]
WantedBy=multi-user.target
EOF

echo "[*] Enabling and starting bedrock.service..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable bedrock
sudo systemctl start bedrock

echo
echo "[✓] Installation complete!"
echo
echo "Manage the server with:"
echo "  sudo systemctl start bedrock"
echo "  sudo systemctl stop bedrock"
echo "  sudo systemctl restart bedrock"
echo "  sudo systemctl status bedrock"
echo
echo "Edit server config with:"
echo "  nano ~/Minecraft/bedrock/server.properties"
echo
echo "✅ Make sure UDP port 19132 is open in Oracle Cloud and VPS firewall!"
