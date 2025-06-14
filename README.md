# 🟩 Bedrock Server for Oracle Cloud (1GB RAM)

This setup is optimized to run a lightweight **Minecraft Bedrock Dedicated Server** on an **Oracle Cloud Free Tier VM** with **1GB RAM**. It includes swap setup, auto-restart, and clean configuration management.

---

## 🚀 Quick Setup

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git
cd bedrock-server-oracle
chmod +x install.sh start.sh
./install.sh
```

Then start the server:

```bash
cd ../bedrock
./start.sh
```

---

## ✅ Features

- Designed for 1GB RAM Oracle VM
- 1GB swap setup (persistent)
- Auto-restart on server crash
- Folder structure:
  - `Minecraft/bedrock`: Server files
  - `Minecraft/bedrock-server-oracle`: Setup scripts
- `server.properties` included
- `screen` session support

---

## 📦 Step-by-Step Deployment Guide

### 1. Prepare Your VM

Update and install dependencies:

```bash
sudo apt update && sudo apt install unzip screen wget -y
```

Clone this repo:

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git
cd bedrock-server-oracle
chmod +x install.sh start.sh
```

---

### 2. Get the Bedrock Server File

**Option A — Download directly:**

```bash
wget -O ../bedrock/bedrock-server.zip https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.84.1.zip
```

**Option B — Use SCP if `wget` fails:**

1. Download the `.zip` manually from the [official site](https://www.minecraft.net/en-us/download/server/bedrock).
2. Upload it:

```bash
scp bedrock-server-1.21.84.1.zip ubuntu@your-server-ip:~/Minecraft/bedrock/bedrock-server.zip
```

---

### 3. Run the Installer

```bash
./install.sh
```

The script will:

- Update packages
- Install unzip, screen, wget
- Extract the server ZIP
- Setup 1GB swap
- Copy `server.properties`

---

### 4. Start the Server

Use inside a `screen` session to keep it alive:

```bash
screen -S bedrock
cd ../bedrock
./start.sh
```

- **Detach**: `Ctrl+A` then `D`
- **Reattach**: `screen -r bedrock`

---

### 5. Open Port 19132 (UDP) in Oracle Cloud

1. Go to Oracle Cloud → **Networking > VCN > Subnets > Security Lists**
2. Add **Ingress Rule**:
   - **Protocol**: UDP
   - **Port**: `19132`
   - **Source CIDR**: `0.0.0.0/0`

---

### 6. Connect from Minecraft

- Platform: **Bedrock Edition (Mobile, Windows 10, Console)**
- Server IP: **Your Oracle Cloud public IP**
- Port: `19132` (default)

---

## 🛠 Tips

- Check memory usage:

  ```bash
  free -h
  top
  ```

- View server logs:

  ```bash
  tail -f ../bedrock/logs/latest.log
  ```

- Auto-start on reboot:
  ```bash
  crontab -e
  @reboot screen -dmS bedrock ~/Minecraft/bedrock-server-oracle/start.sh
  ```

---

## 🙌 Support & Donation

If this project helped you, please consider supporting:

[![Donate with PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal)](https://www.paypal.me/jleonoras)  
[☕ Buy Me a Coffee](https://www.buymeacoffee.com/jleonoras)

Thanks for helping keep the blocky goodness alive! 🧱💖
