#!/bin/bash
# start.sh — Start Minecraft Bedrock Server with screen session

BEDROCK_DIR="$HOME/Minecraft/bedrock"
SESSION_NAME="bedrock"

# Check if bedrock_server binary exists
if [ ! -f "$BEDROCK_DIR/bedrock_server" ]; then
    echo "[!] bedrock_server not found in $BEDROCK_DIR"
    echo "Make sure you've installed the server correctly."
    exit 1
fi

# Navigate to server directory
cd "$BEDROCK_DIR"

# Start server inside a screen session
if screen -list | grep -q "$SESSION_NAME"; then
    echo "[!] A screen session named '$SESSION_NAME' is already running."
    echo "To attach: screen -r $SESSION_NAME"
    exit 1
fi

echo "[*] Starting Minecraft Bedrock server in screen session '$SESSION_NAME'..."
screen -dmS "$SESSION_NAME" ./bedrock_server

echo "[✓] Server started!"
echo "Use 'screen -r $SESSION_NAME' to attach to the session."
