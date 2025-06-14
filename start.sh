#!/bin/bash
# start.sh — Starts the Bedrock server in an infinite loop
# Run this inside a screen session for persistence: screen -S bedrock ./start.sh

cd "$(dirname "$0")/../bedrock"

while true
do
  echo "[*] Starting Bedrock server at $(date)..."
  ./bedrock_server
  echo "[!] Server stopped at $(date). Restarting in 10 seconds..."
  sleep 10
done
