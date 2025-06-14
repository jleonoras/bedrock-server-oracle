#!/bin/bash
# start.sh — Starts the Minecraft Bedrock Server inside a screen session

cd ~/Minecraft/bedrock

# Safety check
if [ ! -f bedrock_server ]; then
  echo "[!] bedrock_server not found! Make sure you have installed the server correctly."
  exit 1
fi

echo "[*] Starting Minecraft Bedrock server..."

# Start the server in a named screen session (or attach if it's already running)
if screen -list | grep -q "bedrock"; then
  echo "[i] A screen session named 'bedrock' is already running."
  echo "[i] Attaching to it..."
  screen -r bedrock
else
  screen -dmS bedrock ./bedrock_server
  echo "[✓] Server started in a detached screen session named 'bedrock'."
  echo "    Use 'screen -r bedrock' to view it."
fi
