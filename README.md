# 🟩 Bedrock Server for Oracle Cloud (1GB RAM)

This setup is optimized to run a lightweight **Minecraft Bedrock Dedicated Server** on an **Oracle Cloud Free Tier VM** with **1GB RAM**. It includes swap setup, auto-restart, and clean configuration management.

---

## 📦 Features

- ✅ Pre-packaged Bedrock server ZIP
- 🌀 Auto-start on system reboot
- 🧠 1GB swap space for stability
- ⚙️ Pre-tuned `server.properties` guidance
- 💥 Runs in `screen-based` session for resilience

---

## 📂 Folder Structure

```text
Minecraft/
├── bedrock/
│ ├── bedrock_server
│ ├── server.properties
│ └── bedrock-server.zip
│
└── bedrock-server-oracle/
  ├── install.sh
  ├── start.sh
  ├── README.md
  └── bedrock-server-<version>.zip
```

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git ~/Minecraft/bedrock-server-oracle
cd ~/Minecraft/bedrock-server-oracle
chmod +x install.sh start.sh
```

### 2. Upload the Bedrock Server ZIP

```bash
wget -O ~/Minecraft/bedrock-server-oracle/bedrock-server-1.21.84.1.zip https://bedrock.jleonoras.eu.org/bedrock-server-1.21.84.1.zip
```

### 3. Install the Server

```bash
./install.sh
```

This script will:

- Update the system
- Install required packages
- Extract Bedrock server into ~/Minecraft/bedrock/
- Create a 1GB swap file
- Add auto-start at reboot via crontab

### 4. Start the Server

```bash
cd ~/Minecraft/bedrock-server-oracle
./start.sh
```

To run in the background using screen:

```bash
screen -S bedrock
./start.sh
```

To detach:

```text
Ctrl+A, then D
```

To reattach:

```bash
screen -r bedrock
```

---

### 🔁 Auto-Start on Reboot

The installer adds this to crontab:

```bash
@reboot screen -dmS bedrock $HOME/Minecraft/bedrock-server-oracle/start.sh
```

You can confirm it with:

```bash
crontab -l
```

---

### 🔓 Open Port 19132 (UDP) on Oracle Cloud

1. Go to Oracle Cloud Console

2. Navigate: Networking → VCN → Subnets → Security Lists

3. Add **Ingress Rule**:
   - **Protocol**: UDP
   - **Port**: `19132`
   - **Source CIDR**: `0.0.0.0/0`

---

### 🎮 Connect From Minecraft

- Platform: **Bedrock Edition (Mobile, Windows 10, Console)**
- Server IP: **Your Oracle Cloud public IP**
- Port: `19132` (default)
- Works with all compatible Bedrock clients

---

### ⚙️ Recommended server.properties

Edit server.properties manually inside ~/Minecraft/bedrock/ with these settings:

Edit manually:

```bash
nano ~/Minecraft/bedrock/server.properties
```

Suggested config:

```text
max-players=5
view-distance=5
tick-distance=3
player-idle-timeout=10
white-list=true
online-mode=true
```

---

### 🛠️ Server Management Tips

- Check memory usage:

  ```bash
  free -h
  top
  ```

- View server logs:

  ```bash
  tail -f ~/Minecraft/bedrock/logs/latest.log
  ```

- Stop the server:

  Inside the screen, press Ctrl+C, or type stop if in-game.

---

### 🙌 Support & Donations

If this project helped you, please consider supporting:

[![Donate with PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal)](https://www.paypal.me/jleonoras)  
[☕ Buy Me a Coffee](https://www.buymeacoffee.com/jleonoras)

Thanks for helping keep the blocky goodness alive! 🧱💖
