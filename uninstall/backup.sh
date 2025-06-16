#!/bin/bash
# backup.sh — Backup Minecraft Bedrock server data (no compression)

set -e

BEDROCK_DIR="$HOME/Minecraft/bedrock"
BACKUP_DIR="$HOME/Minecraft/backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_PATH="$BACKUP_DIR/backup_$TIMESTAMP"

echo "[*] Stopping Minecraft server before backup..."
sudo systemctl stop bedrock || true

# Verify that worlds exist
if [ ! -d "$BEDROCK_DIR/worlds" ] || [ -z "$(ls -A "$BEDROCK_DIR/worlds")" ]; then
  echo "[!] No world data found in $BEDROCK_DIR/worlds"
  exit 1
fi

mkdir -p "$BACKUP_PATH"

echo "[*] Copying worlds and server config files to $BACKUP_PATH..."
cp -r "$BEDROCK_DIR/worlds" "$BACKUP_PATH/"
cp -p "$BEDROCK_DIR"/{server.properties,permissions.json,allowlist.json} "$BACKUP_PATH/" 2>/dev/null || true

echo "[✓] Backup complete!"
echo "Saved to: $BACKUP_PATH"
echo ""
echo "📦 Files backed up:"
[[ -d "$BACKUP_PATH/worlds" ]] && echo " - worlds/ (all world data)"
[[ -f "$BACKUP_PATH/server.properties" ]] && echo " - server.properties"
[[ -f "$BACKUP_PATH/permissions.json" ]] && echo " - permissions.json"
[[ -f "$BACKUP_PATH/allowlist.json" ]] && echo " - allowlist.json"

echo ""
echo "[*] Restarting Minecraft server..."
sudo systemctl start bedrock || true
