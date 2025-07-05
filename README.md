# 🟩 Bedrock Server for Oracle Cloud (1GB RAM)

This setup is optimized to run a lightweight **Minecraft Bedrock Dedicated Server** on an **Oracle Cloud Free Tier VM** with **1GB RAM**. It includes swap setup, systemd-based service for auto-start, and clean directory structure.

---

## 📦 Features

- ✅ Ready-to-use Bedrock server ZIP.
  No need to download from Mojang manually — just upload and install.
- 🔁 Auto-start on reboot with `systemd`.
  Your server comes back online automatically after a restart.
- ⚙️ Managed with `systemctl`.
  Start, stop, or restart cleanly with simple commands — no `screen` needed.

- 🧠 1GB Swap file setup.
  Helps prevent crashes on 1GB RAM Oracle Cloud VMs.
- 🔧 Pre-tuned server.properties
  Recommended settings included for best performance and stability.
- 🧼 Clean folder structure.
  Separates server files from setup scripts for easy updates.

---

## 📂 Folder Structure

```text
Minecraft/
├── bedrock/
│   ├── bedrock_server
│   ├── server.properties
│   └── bedrock-server.zip
├── backup/
│   └── (world files...)
└── bedrock-server-oracle/
    ├── install.sh
    ├── start.sh
    ├── download.sh
    ├── README.md
    ├── bedrock-server-<version>.zip
    ├── backup/
    ├── uninstall/
    └── restore/
```

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/jleonoras/bedrock-server-oracle.git ~/Minecraft/bedrock-server-oracle
cd ~/Minecraft/bedrock-server-oracle
chmod +x install.sh start.sh download.sh
```

### 2. Download the Bedrock Server ZIP

Run the download script. It will prompt you to paste the download link for the server.

```bash
./download.sh
```

1. The script will show you the official Minecraft download page URL.
2. Go to that page in your browser.
3. Find the Linux server download link, right-click it, and select "Copy Link Address".
4. Paste the copied link into the terminal when prompted and press Enter.

The script will then download the server ZIP file into the `~/Minecraft/bedrock-server-oracle/` directory.

### 3. Install the Server

```bash
./install.sh
```

This script will:

- Install required packages
- Set up `~/Minecraft/` folder structure
- Extract the Bedrock server
- Create 4GB swap file
- Set up and enable a `systemd` service

### ▶️ Starting / Stopping the Server

The installer automatically enables `minecraft-bedrock.service`, so the server starts on boot.

You can manage the server using standard Linux service commands:

`sudo systemctl start bedrock`

`sudo systemctl stop bedrock`

`sudo systemctl restart bedrock`

To check its status:

```bash
sudo systemctl status bedrock
```

---

### 🧰 Accessing the Server Console (Advanced)

The actual server runs in the background using a **screen** session, launched by `systemd`.

To interact with it manually:

### View available screen sessions:

```bash
screen -ls
```

### Attach to the session:

```bash
screen -r bedrock
```

### Detach from the session (keep it running):

While inside the screen:

`Ctrl + A`, then `D`

---

### 🛠️ Monitoring & Logs

- Check memory usage:

  ```bash
  free -h
  top
  ```

- Stop the server:

Inside the screen, press `Ctrl + C` to stop the server.

---

### 🔓 Open Port 19132 (UDP) on Oracle Cloud

1. Oracle Cloud Console

- Navigate: Networking → VCN → Subnets → Security Lists

- Add a new **Ingress Rule**:

  - **Protocol**: UDP
  - **Port**: `19132`
  - **Source CIDR**: `0.0.0.0/0`

2. In your VPS (Ubuntu/Debian)

If using ufw:

```bash
sudo ufw allow 19132/udp
sudo ufw reload
```

- 💡 Skip if `ufw` is not enabled. (`sudo ufw status`)

---

### 🎮 Connect From Minecraft

- Platform: **Bedrock Edition (Mobile, Windows 10, Console)**
- Server IP: **Your Oracle Cloud public IP**
- Port: `19132` (default)
- Works with all compatible Bedrock clients

---

### ⚙️ Recommended `server.properties`

Edit the file:

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

### 🧹 **Want to uninstall and do a fresh install?**

See [Uninstall Guide](uninstall/README.md)

---

### 🙌 Support & Donations

If this project helped you, please consider supporting:

[![Donate with PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg?logo=paypal)](https://www.paypal.me/jleonoras)  
[![Buy Me a Coffee](https://img.shields.io/badge/Buy_Me_a_Coffee-support-yellow.svg?logo=buy-me-a-coffee)](https://www.buymeacoffee.com/jleonoras)

Thanks for helping keep the blocky goodness alive! 🧱💖
