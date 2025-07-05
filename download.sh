#!/bin/bash
# download.sh — Automatically fetches the latest Bedrock Server link from minecraft.net (Updated)

set -e

# --- Configuration ---
DEST_DIR=~/Minecraft/bedrock-server-oracle
# A browser User-Agent is required because minecraft.net blocks tools like curl/wget
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
MINECRAFT_URL="https://www.minecraft.net/en-us/download/server/bedrock"

# --- Script ---
mkdir -p "$DEST_DIR"

echo "[*] Fetching latest download link from minecraft.net..."

# Fetch the webpage content, exit with an error if curl fails
PAGE_CONTENT=$(curl -A "$USER_AGENT" -s -L --fail "$MINECRAFT_URL")
if [ $? -ne 0 ]; then
  echo "[!] Failed to fetch the download page. Check your internet connection or the URL: $MINECRAFT_URL"
  exit 1
fi

# Scrape the webpage to find the official download URL for the Linux binary
# This method is more robust as it looks for the specific data-platform attribute for Linux
DOWNLOAD_URL=$(echo "$PAGE_CONTENT" | grep 'data-platform="serverBedrockLinux"' | grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "[!] Could not find download link on the page. The website structure has likely changed again."
  echo "[!] Please check the official Minecraft download page manually."
  exit 1
fi

# Get the filename from the full URL
FILENAME=$(basename "$DOWNLOAD_URL")
DEST="$DEST_DIR/$FILENAME"

echo "[*] Found URL: $DOWNLOAD_URL"
echo "[*] Downloading $FILENAME to $DEST..."

# Use wget with the same User-Agent to download the file
# The --show-progress flag provides better feedback
wget -U "$USER_AGENT" -O "$DEST" --show-progress "$DOWNLOAD_URL"

echo "" # Newline for cleaner output
echo "[✓] Download complete: $DEST"