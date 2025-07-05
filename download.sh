#!/bin/bash
# download.sh — Fetches the latest Bedrock Server link directly from the Minecraft download page

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
DEST_DIR=~/Minecraft/bedrock-server-oracle
# The User-Agent is still good practice for API calls.
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
# This is the main download page which contains the version history data.
API_URL="https://www.minecraft.net/en-us/download/server/bedrock"

# --- Script ---
echo "[*] Ensuring required tools (curl, jq) are installed..."
# Check for jq and install if it's not present.
if ! command -v jq &> /dev/null; then
    echo "[i] 'jq' (JSON processor) not found. Installing..."
    sudo apt-get update && sudo apt-get install -y jq
fi

# Create the destination directory if it doesn't exist.
mkdir -p "$DEST_DIR"

echo "[*] Fetching latest download link from minecraft.net..."

# Fetch the JSON data embedded in the main download page's HTML.
# 1. Use grep to find the 'data-versions' attribute, which contains the JSON data in single quotes.
# 2. Use sed to strip away the 'data-versions=' part and the single quotes.
# 3. Use jq to parse the JSON, get the URL for the latest version (the first in the array), and remove quotes.
DOWNLOAD_URL=$(curl -A "$USER_AGENT" -s -L "$API_URL" | \
    grep -o "data-versions='[^']*'" | \
    sed "s/data-versions=//;s/'//g" | \
    jq -r '.[0].platforms."linux.x64".url')


# Check if the DOWNLOAD_URL variable is empty.
if [ -z "$DOWNLOAD_URL" ]; then
  echo "[!] Could not find a valid download link from the page's data."
  echo "[!] The website's data structure may have changed. Please check the API_URL manually."
  exit 1
fi

# Get the filename from the full URL.
FILENAME=$(basename "$DOWNLOAD_URL")
DEST="$DEST_DIR/$FILENAME"

echo "[*] Found URL: $DOWNLOAD_URL"
echo "[*] Downloading $FILENAME to $DEST..."

# Use wget to download the file.
wget -U "$USER_AGENT" -O "$DEST" --show-progress "$DOWNLOAD_URL"

echo "" # Newline for cleaner output
echo "[✓] Download complete: $DEST"
