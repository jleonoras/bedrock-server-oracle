#!/bin/bash
# restore.sh — Restores a non-zipped Minecraft Bedrock server backup

set -e

BACKUP_DIR="$HOME/Minecraft/backups"
BEDROCK_DIR="$HOME/Minecraft/bedrock"
WORLD_DIR="$BEDROCK_DIR/worlds"

echo "[*] Looking for latest backup in: $BACKUP_DIR"

# Find latest backup directory
LATEST_BACKUP=$(ls -dt "$BACKUP_DIR"/backup_* 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "[!] No backup directories found in $BACKUP_DIR"
  exit 1
fi

echo "[*] Found latest backup: $LATEST_BACKUP"

# Ensure target directories exist
mkdir -p "$WORLD_DIR"

echo "[*] Stopping Minecraft server before restore..."
sudo systemctl stop bedrock || true

echo "[*] Clearing current world and config files..."
rm -rf "$WORLD_DIR"/*
rm -f "$BEDROCK_DIR"/server.properties "$BEDROCK_DIR"/permissions.json "$BEDROCK_DIR"/allowlist.json

echo "[*] Restoring backup data..."
cp -r "$LATEST_BACKUP/worlds/"* "$WORLD_DIR/"
cp -p "$LATEST_BACKUP"/server.properties "$BEDROCK_DIR/" 2>/dev/null || true
cp -p "$LATEST_BACKUP"/permissions.json "$BEDROCK_DIR/" 2>/dev/null || true
cp -p "$LATEST_BACKUP"/allowlist.json "$BEDROCK_DIR/" 2>/dev/null || true

echo "[*] Restarting Minecraft server..."
sudo systemctl start bedrock || true

echo "[✓] World and config restored successfully from: $LATEST_BACKUP"
