# Bedrock Server for Oracle Cloud (1GB RAM)

This setup is optimized to run a lightweight Minecraft Bedrock Dedicated Server on an Oracle Cloud Free Tier VM (1GB RAM).

## Setup

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git
cd bedrock-server-oracle
chmod +x install.sh start.sh
./install.sh
```

After installation:

```bash
cd ~/bedrock
./start.sh
```

## Features

- Swap-enabled
- Auto-restart on crash
- Small view/tick distance for performance
- Configurable via `server.properties`

## 📦 Step-by-Step Deployment Guide

### 1. Download the Server Setup

SSH into your VM, then run:

```bash
wget https://chat.openai.com/sandbox/bedrock-server-oracle.zip
unzip bedrock-server-oracle.zip
cd bedrock-server-oracle
chmod +x install.sh start.sh
```

If `wget` fails, download the ZIP locally and upload to the server via SCP:

```bash
scp bedrock-server-oracle.zip ubuntu@your-server-ip:~
```

---

### 2. Run the Installer

```bash
./install.sh
```

This script will:
- Update your system
- Install `unzip`, `screen`, and `wget`
- Download the Bedrock server
- Set up 1GB of swap space (needed for 1GB RAM)
- Apply lightweight server settings

---

### 3. Start the Server

```bash
./start.sh
```

Or use `screen` to keep it running in the background:

```bash
screen -S bedrock
./start.sh
# Detach with Ctrl+A then D
```

To reattach:
```bash
screen -r bedrock
```

---

### 4. Open Port 19132 (UDP) in Oracle Cloud

1. Go to Oracle Cloud Console → Networking → VCN → Subnets → Security Lists
2. Add an Ingress Rule:
   - **Protocol**: UDP
   - **Port**: 19132
   - **Source CIDR**: 0.0.0.0/0

---

### 5. Connect from Minecraft

- Use your Oracle Cloud **public IP**
- **Port**: 19132
- Version: Any compatible Bedrock version

---

### 🛠️ Tips

- Monitor RAM usage:
  ```bash
  free -h
  top
  ```

- Monitor logs:
  ```bash
  tail -f ~/bedrock/logs/latest.log
  ```

- Start server on boot:
  ```bash
  crontab -e
  @reboot screen -dmS bedrock ~/bedrock-server-oracle/start.sh
  ```

---

## 🙌 Support & Donation

If this project helped you or saved you time, consider buying me a coffee!

☕ [Buy Me a Coffee](https://www.buymeacoffee.com/jleonoras)

Or support via:

- <a href="https://www.paypal.me/jleonoras" target="_blank">
  <img src="https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal" alt="Donate with PayPal" />
</a>

Thanks for keeping the blocky goodness alive! 🧱💖
