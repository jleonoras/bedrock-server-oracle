#!/bin/bash
# download.sh — Automatically fetches the latest Bedrock Server link from minecraft.net

set -e

# --- Configuration ---
DEST_DIR=~/Minecraft/bedrock-server-oracle
# A browser User-Agent is required because minecraft.net may block tools like curl/wget
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
MINECRAFT_URL="https://www.minecraft.net/en-us/download/server/bedrock"

# --- Script ---
mkdir -p "$DEST_DIR"

echo "[*] Fetching latest download link from minecraft.net..."

# Scrape the webpage to find the official download URL for the Linux binary
# The new method looks for a data attribute specifically for the Linux download
DOWNLOAD_URL=$(curl -A "$USER_AGENT" -s "$MINECRAFT_URL" | grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "[!] Could not find download link on the page. The website structure might have changed again."
  exit 1
fi

# Get the filename from the full URL (e.g., bedrock-server-1.21.93.1.zip)
FILENAME=$(basename "$DOWNLOAD_URL")
DEST="$DEST_DIR/$FILENAME"

echo "[*] Found URL: $DOWNLOAD_URL"
echo "[*] Downloading $FILENAME..."

# Use wget with the same User-Agent to download the file
wget -U "$USER_AGENT" -O "$DEST" "$DOWNLOAD_URL"

echo "[✓] Download complete: $DEST"