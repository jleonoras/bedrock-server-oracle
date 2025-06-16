# 🗑️ Uninstalling Minecraft Bedrock Server on Oracle Cloud

This script safely removes your Bedrock server setup from an Oracle Cloud Free Tier VM.  
It stops the service, removes swap, and deletes server files — **without touching your backups**.

---

## 🚫 What This Will Do

- Stops and disables the `bedrock` `systemd` service
- Removes the `systemd` service file
- Deletes the `bedrock/` and `bedrock-server-oracle/` folders
- Removes the swap file created by the installer

✅ Your `~/Minecraft/` folder will stay — useful if you have world backups there.

---

## 🧹 Uninstall Instructions

### ✅ Step 1: Back Up Your World

Before uninstalling, it’s highly recommended to back up your world data.

```bash
cd ~/Minecraft/bedrock-server-oracle/backup
chmod +x backup.sh
./backup.sh
```

This will save your world into a ZIP file inside:

`~/Minecraft/backups/`

### 🧹 Step 2: Uninstall the Server

This will stop and remove the Bedrock service, delete the server files, and remove the swap configuration (if any).

```bash
cd ~/Minecraft/bedrock-server-oracle/uninstall
chmod +x uninstall.sh
./uninstall.sh
```

What this does:

- Stops and disables `bedrock` `systemd` service.

- Deletes the service file.

- Removes the 1GB swap file.

- Deletes only:

  - `~/Minecraft/bedrock/`

  - `~/Minecraft/bedrock-server-oracle/`

It does not delete the `~/Minecraft/backups/` folder.

---

### 🔁 Reinstalling Later?

To reinstall the Minecraft Bedrock server, just follow the installation steps.

See [📄 Install Guide](../README.md)

---

### ♻️ Want to restore your world after reinstalling?

See [📄 Restore Guide](../restore/README.md)
