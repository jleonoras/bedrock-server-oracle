#!/bin/bash
# backup.sh — Backup Minecraft Bedrock world before uninstalling

set -e

BEDROCK_DIR="$HOME/Minecraft/bedrock"
WORLD_DIR="$BEDROCK_DIR/worlds"
BACKUP_DIR="$HOME/Minecraft/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/world_backup_$TIMESTAMP.zip"

echo "[*] Stopping Minecraft server before backup..."
sudo systemctl stop bedrock || true

if [ ! -d "$WORLD_DIR" ] || [ -z "$(ls -A "$WORLD_DIR")" ]; then
  echo "[!] No world data found in $WORLD_DIR"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

echo "[*] Backing up world data to $BACKUP_FILE..."
zip -r "$BACKUP_FILE" "$WORLD_DIR" > /dev/null

echo "[✓] Backup complete!"
echo "Saved to: $BACKUP_FILE"

echo "[*] Restarting Minecraft server..."
sudo systemctl start bedrock || true
