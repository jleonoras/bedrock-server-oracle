#!/bin/bash
# uninstall.sh — Uninstalls the Bedrock server setup from Oracle Cloud (safe)

set -e

echo "[*] Stopping and disabling bedrock.service..."
sudo systemctl stop bedrock || true
sudo systemctl disable bedrock || true

echo "[*] Removing systemd service file..."
sudo rm -f /etc/systemd/system/bedrock.service
sudo systemctl daemon-reload

echo "[*] Removing swap file..."
sudo swapoff /swapfile || true
sudo rm -f /swapfile
sudo sed -i '/\/swapfile/d' /etc/fstab

echo "[*] Deleting Minecraft/bedrock and bedrock-server-oracle folders..."
rm -rf ~/Minecraft/bedrock
rm -rf ~/Minecraft/bedrock-server-oracle

echo
echo "[✓] Uninstall complete."
echo "Your backups in ~/Minecraft (if any) are untouched."
