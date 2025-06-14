#!/bin/bash
# start.sh — Starts the Minecraft Bedrock Server inside a screen session

cd ~/Minecraft/bedrock

# Set library path so bedrock_server can find needed shared libraries
export LD_LIBRARY_PATH=$(pwd)

# Check for server binary
if [ ! -f bedrock_server ]; then
  echo "[!] bedrock_server not found! Did you run install.sh?"
  exit 1
fi

echo "[*] Checking for existing 'bedrock' screen sessions..."

# Kill all zombie bedrock sessions
while screen -list | grep -q "\.bedrock"; do
  OLD_ID=$(screen -list | grep "\.bedrock" | awk '{print $1}')
  echo "[!] Killing stale screen session: $OLD_ID"
  screen -S "${OLD_ID}" -X quit
  sleep 1
done

echo "[*] Starting Minecraft Bedrock server in screen session 'bedrock'..."
screen -dmS bedrock ./bedrock_server

echo "[✓] Server started in screen session 'bedrock'."
echo "    Use 'screen -r bedrock' to attach."
