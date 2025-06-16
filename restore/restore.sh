#!/bin/bash
# restore.sh — Restores a backed-up Minecraft Bedrock world

set -e

BACKUP_DIR="$HOME/Minecraft/backups"
WORLD_DIR="$HOME/Minecraft/bedrock/worlds"

echo "[*] Looking for latest backup in: $BACKUP_DIR"

# Find latest backup ZIP file (corrected pattern)
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/world_backup_*.zip 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "[!] No backup files found in $BACKUP_DIR"
  exit 1
fi

echo "[*] Found latest backup: $LATEST_BACKUP"

# Ensure world directory exists
mkdir -p "$WORLD_DIR"

echo "[*] Stopping server before restoring..."
sudo systemctl stop bedrock || true

echo "[*] Clearing existing world..."
rm -rf "$WORLD_DIR"/*

echo "[*] Restoring backup..."
unzip -o "$LATEST_BACKUP" -d "$WORLD_DIR"

echo "[*] Restarting server..."
sudo systemctl start bedrock

echo "[✓] World restored successfully from backup."
