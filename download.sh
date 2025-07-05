#!/bin/bash
# download.sh — Robustly fetches the latest Bedrock Server link from minecraft.net

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
DEST_DIR=~/Minecraft/bedrock-server-oracle
# A browser User-Agent is required because minecraft.net blocks tools like curl/wget
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
MINECRAFT_URL="https://www.minecraft.net/en-us/download/server/bedrock"

# --- Script ---
# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

echo "[*] Fetching latest download link from minecraft.net..."

# Fetch the webpage content using curl. The -L flag follows redirects.
# Exit with an error if curl fails.
PAGE_CONTENT=$(curl -A "$USER_AGENT" -s -L --fail "$MINECRAFT_URL")
if [ $? -ne 0 ]; then
  echo "[!] Failed to fetch the download page. Check your internet connection or the URL: $MINECRAFT_URL"
  exit 1
fi

# Scrape the webpage to find the official download URL for the Linux binary.
# This new, more flexible regex looks for the common URL structure regardless of the domain name.
DOWNLOAD_URL=$(echo "$PAGE_CONTENT" | grep -o 'https://[^"]*/bin-linux/bedrock-server-[^"]*\.zip' | head -n 1)

# Check if the DOWNLOAD_URL variable is empty. If it is, the link wasn't found.
if [ -z "$DOWNLOAD_URL" ]; then
  echo "[!] Could not find a valid download link on the page. The website structure has likely changed in a new way."
  echo "[!] Please check the official Minecraft download page manually and update the script's grep pattern if needed."
  exit 1
fi

# Get the filename from the full URL (e.g., bedrock-server-1.21.93.1.zip)
FILENAME=$(basename "$DOWNLOAD_URL")
DEST="$DEST_DIR/$FILENAME"

echo "[*] Found URL: $DOWNLOAD_URL"
echo "[*] Downloading $FILENAME to $DEST..."

# Use wget with the same User-Agent to download the file.
# The --show-progress flag provides better feedback during the download.
wget -U "$USER_AGENT" -O "$DEST" --show-progress "$DOWNLOAD_URL"

echo "" # Newline for cleaner output
echo "[✓] Download complete: $DEST"
