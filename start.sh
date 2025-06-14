#!/bin/bash
# start.sh — Starts the Minecraft Bedrock Server inside a screen session

cd ~/Minecraft/bedrock

# Check for server binary
if [ ! -f bedrock_server ]; then
  echo "[!] bedrock_server not found! Did you run install.sh?"
  exit 1
fi

echo "[*] Starting Minecraft Bedrock server..."

# Start or reattach to screen session
if screen -list | grep -q "bedrock"; then
  echo "[i] Screen session 'bedrock' already running."
  echo "[i] Attaching..."
  screen -r bedrock
else
  screen -dmS bedrock bash -c 'LD_LIBRARY_PATH=. ./bedrock_server'
  echo "[✓] Server started in screen session 'bedrock'."
  echo "    Use 'screen -r bedrock' to attach."
fi
