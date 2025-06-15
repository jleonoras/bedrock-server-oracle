#!/bin/bash
# download.sh — Automatically fetches and downloads the latest Bedrock Server ZIP

set -e

DEST_DIR=~/Minecraft/bedrock-server-oracle
mkdir -p "$DEST_DIR"

echo "[*] Fetching latest version info..."
LATEST_VERSION=$(curl -s https://bedrock.jleonoras.eu.org/latest.txt)

if [ -z "$LATEST_VERSION" ]; then
  echo "[!] Could not fetch latest version. Exiting."
  exit 1
fi

FILENAME="bedrock-server-$LATEST_VERSION.zip"
URL="https://bedrock.jleonoras.eu.org/$FILENAME"
DEST="$DEST_DIR/$FILENAME"

echo "[*] Downloading Bedrock Server $LATEST_VERSION..."
wget -O "$DEST" "$URL"

echo "[✓] Downloaded to: $DEST"
