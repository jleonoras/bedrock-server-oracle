#!/bin/bash
# install.sh — Automated Bedrock Server setup for Oracle Cloud (1GB RAM)

set -e

# Define directories
ROOT_DIR="$HOME/Minecraft"
BEDROCK_DIR="$ROOT_DIR/bedrock"
REPO_DIR="$ROOT_DIR/bedrock-server-oracle"
ZIP_FILE="$BEDROCK_DIR/bedrock-server.zip"
SERVER_URL="https://www.minecraft.net/content/dam/minecraft-bedrock-server/bedrock-server-1.21.84.1.zip"

echo "[*] Updating system..."
sudo apt update && sudo apt upgrade -y
sudo apt install unzip screen wget -y

echo "[*] Creating folder structure..."
mkdir -p "$BEDROCK_DIR"
mkdir -p "$REPO_DIR"

# Download if ZIP not found
if [ ! -f "$ZIP_FILE" ]; then
    echo "[*] Bedrock server ZIP not found, attempting download..."
    if wget -O "$ZIP_FILE" "$SERVER_URL"; then
        echo "[✓] Download successful."
    else
        echo "[!] Failed to download Bedrock server."
        echo "    Please download it manually and upload to:"
        echo "    $ZIP_FILE"
        exit 1
    fi
else
    echo "[✓] Found existing bedrock-server.zip at $ZIP_FILE"
fi

# Extract server
cd "$BEDROCK_DIR"
echo "[*] Extracting Bedrock server..."
unzip -o bedrock-server.zip
chmod +x bedrock_server

# Setup swap if not already enabled
echo "[*] Setting up 1GB swap file..."
if ! sudo swapon --show | grep -q '/swapfile'; then
    sudo fallocate -l 1G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=1024
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    grep -q '/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
    echo "[✓] Swap file created."
else
    echo "[✓] Swap file already active."
fi

# Copy server config
echo "[*] Copying server.properties..."
cp "$REPO_DIR/server.properties" "$BEDROCK_DIR/server.properties"

echo "[✓] Setup complete!"
echo "To start the server, run:"
echo "cd $BEDROCK_DIR && ./start.sh"
