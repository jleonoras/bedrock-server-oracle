#!/bin/bash
# backup.sh — Backup Minecraft Bedrock world before uninstalling

set -e

# Check for zip
if ! command -v zip &> /dev/null; then
  echo "[*] 'zip' not found. Installing..."
  sudo apt update
  sudo apt install zip -y
fi

BEDROCK_DIR="$HOME/Minecraft/bedrock"
BACKUP_DIR="$HOME/Minecraft/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/world_backup_$TIMESTAMP.zip"

if [ ! -d "$BEDROCK_DIR/worlds" ]; then
  echo "[!] No world data found in $BEDROCK_DIR/worlds"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

echo "[*] Backing up world data to $BACKUP_FILE..."
zip -r "$BACKUP_FILE" "$BEDROCK_DIR/worlds" > /dev/null

echo "[✓] Backup complete!"
echo "Saved to: $BACKUP_FILE"
