#!/bin/bash
# start.sh — Starts the Minecraft Bedrock Server in a screen session named 'bedrock'

BEDROCK_DIR="$HOME/Minecraft/bedrock"
cd "$BEDROCK_DIR"

# Check if the server binary exists
if [ ! -f bedrock_server ]; then
  echo "[!] bedrock_server not found in $BEDROCK_DIR"
  echo "    Did you run install.sh?"
  exit 1
fi

echo "[*] Starting Minecraft Bedrock server..."
export LD_LIBRARY_PATH="$BEDROCK_DIR"

# Check if screen session 'bedrock' is already running
if screen -list | grep -q "\.bedrock"; then
  echo "[i] Screen session 'bedrock' is already running."
else
  screen -dmS bedrock ./bedrock_server
  echo "[✓] Server started in screen session 'bedrock'."
  echo "    Use 'screen -r bedrock' to view the console."
fi

# Keeps systemd from marking the service as stopped
tail -f /dev/null
