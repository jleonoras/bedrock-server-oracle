# 🟩 Bedrock Server for Oracle Cloud (1GB RAM)

This setup is optimized to run a lightweight **Minecraft Bedrock Dedicated Server** on an **Oracle Cloud Free Tier VM** with **1GB RAM**. It includes swap setup, auto-restart, and clean configuration management.

---

## 📂 Folder Structure

```text
~/Minecraft/
├── bedrock/                   # Actual Bedrock server files
│   ├── bedrock_server
│   ├── server.properties
│   └── bedrock-server.zip
└── bedrock-server-oracle/     # Your Git repository
    ├── install.sh
    ├── start.sh
    └── README.md
```

---

## 🚀 Setup Instructions

### 1. Clone the Repo

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git ~/Minecraft/bedrock-server-oracle
cd ~/Minecraft/bedrock-server-oracle
chmod +x install.sh start.sh
```

### 2. Download the Bedrock Server

You have two options:

📥 (A) Automatic Download

If wget works in your region, the script will download the server for you:

```bash
./install.sh
```

🔁 (B) Manual Upload via SCP (If wget fails)

1. Download the server ZIP from:

   https://www.minecraft.net/en-us/download/server/bedrock

2. Upload it to your server:

```bash
scp bedrock-server-*.zip ubuntu@<your-server-ip>:~/Minecraft/bedrock/bedrock-server.zip
```

3. Then run the installer:

```bash
./install.sh
```

### ▶️ Starting the Server

From the server directory:

```bash
cd ~/Minecraft/bedrock
./start.sh
```

It will run inside a screen session named bedrock. You can detach with:

```bash
Ctrl + A, then D
```

To reattach:

```bash
screen -r bedrock
```

Then start the server:

```bash
cd ../bedrock
./start.sh
```

---

### 🔓 Open Port 19132 (UDP) on Oracle Cloud

1. Go to Oracle Cloud → Networking > VCN > Subnets > Security Lists
2. Add **Ingress Rule**:
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

### 🛠️ Admin Tips

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

### 🙌 Support & Donations

If this project helped you, please consider supporting:

[![Donate with PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal)](https://www.paypal.me/jleonoras)  
[☕ Buy Me a Coffee](https://www.buymeacoffee.com/jleonoras)

Thanks for helping keep the blocky goodness alive! 🧱💖
