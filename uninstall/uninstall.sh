#!/bin/bash
# uninstall.sh — Uninstalls the Bedrock server setup (keeps swap and backups)

set -e

echo "[*] Stopping and disabling bedrock.service..."
sudo systemctl stop bedrock || true
sudo systemctl disable bedrock || true

echo "[*] Removing systemd service file..."
sudo rm -f /etc/systemd/system/bedrock.service
sudo systemctl daemon-reload

echo "[i] Keeping existing swap file for system stability."
echo "[*] Swap file status:"
swapon --show || echo "No active swap found"
echo

echo "[*] Deleting Minecraft/bedrock and bedrock-server-oracle folders..."
rm -rf ~/Minecraft/bedrock
rm -rf ~/Minecraft/bedrock-server-oracle

echo
echo "[✓] Uninstall complete."
echo "Backups in ~/Minecraft (if any) are preserved"