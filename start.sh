#!/bin/bash
# start.sh — Starts the server in an infinite loop

cd ~/bedrock

while true
do
  echo "[*] Starting Bedrock server..."
  ./bedrock_server
  echo "[!] Server crashed or stopped. Restarting in 10 seconds..."
  sleep 10
done
