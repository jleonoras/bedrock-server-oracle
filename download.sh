#!/bin/bash
# download.sh — Manually downloads a user-provided Minecraft Bedrock Server link.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
DEST_DIR=~/Minecraft/bedrock-server-oracle
# A browser User-Agent is still used for wget to prevent being blocked.
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
MINECRAFT_DOWNLOAD_PAGE="https://www.minecraft.net/en-us/download/server/bedrock"

# --- Script ---
# Create the destination directory if it doesn't exist.
mkdir -p "$DEST_DIR"

# --- User Input Section ---
echo "[!] Automatic link detection has been unreliable."
echo "[*] Please go to the official Minecraft download page to get the latest link:"
echo "    $MINECRAFT_DOWNLOAD_PAGE"
echo
echo "[i] Find the download link for the Linux version, right-click it, and copy the link address."
echo

# Prompt the user to paste the URL.
read -p "[>] Paste the download link here and press Enter: " DOWNLOAD_URL

# --- Validation ---
# Check if the user actually entered a URL.
if [ -z "$DOWNLOAD_URL" ]; then
  echo
  echo "[!] No URL entered. Aborting."
  exit 1
fi

# Basic check to see if the URL looks like a valid Bedrock server zip file.
if [[ ! "$DOWNLOAD_URL" == *"bedrock-server-"*".zip"* ]]; then
  echo
  echo "[!] The URL does not look like a valid Bedrock server zip file."
  echo "    It should contain 'bedrock-server-' and end with '.zip'."
  echo "    Please run the script again with the correct link."
  exit 1
fi

# --- Download Section ---
# Get the filename from the full URL.
FILENAME=$(basename "$DOWNLOAD_URL")
DEST="$DEST_DIR/$FILENAME"

echo
echo "[*] URL received: $DOWNLOAD_URL"
echo "[*] Downloading $FILENAME to $DEST..."

# Use wget with the same User-Agent to download the file.
wget -U "$USER_AGENT" -O "$DEST" --show-progress "$DOWNLOAD_URL"

echo
echo "[✓] Download complete: $DEST"
