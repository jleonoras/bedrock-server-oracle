#!/bin/bash
# install.sh — Simple Minecraft Bedrock Server setup for Oracle Cloud (1GB+ RAM)

set -e

echo "[*] Checking for swap file..."

if grep -q '/swapfile' /proc/swaps; then
  echo "[i] Swap file already exists. Skipping creation."
  swapon --show
else
  echo "[*] Creating 4GB swap file for Minecraft performance..."
  sudo fallocate -l 4G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=4096
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '[✓] Swap file created and enabled.'
  grep -q '^/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab > /dev/null
fi

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

echo "[*] Installing bedrock.service..."
SERVICE_PATH="/etc/systemd/system/bedrock.service"
START_SCRIPT="$HOME/Minecraft/bedrock-server-oracle/start.sh"
USER_NAME=$(whoami)

# 🛠 Write systemd service
SERVICE_PATH="/etc/systemd/system/bedrock.service"
START_SCRIPT="$HOME/Minecraft/bedrock-server-oracle/start.sh"
USER_NAME=$(whoami)

echo "[*] Installing systemd service at $SERVICE_PATH..."

sudo tee "$SERVICE_PATH" > /dev/null <<EOF
[Unit]
Description=Minecraft Bedrock Server
After=network.target

[Service]
User=$USER_NAME
WorkingDirectory=/home/$USER_NAME/Minecraft/bedrock-server-oracle
ExecStart=$START_SCRIPT
ExecStop=/usr/bin/screen -S bedrock -X quit
Restart=no

[Install]
WantedBy=multi-user.target
EOF

echo "[*] Enabling and starting bedrock.service..."
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
