# ♻️ Restore a Minecraft Bedrock Backup

This script restores your Minecraft Bedrock world from a `.zip` file in your `~/Minecraft/backups` folder.

### ✅ How to Restore (Automatic Mode)

To restore the most recent backup:

```bash
cd ~/Minecraft/bedrock-server-oracle/restore
chmod +x restore.sh
./restore.sh
```

This will:

- Stop the Minecraft Bedrock server

- Find the latest `.zip` file in `~/Minecraft/backups`

- Clear the existing world folder

- Restore the world from the backup

- Start the server again

---

### 🛠️ Manual Restore (Optional)

To restore a specific backup file:

```bash
cd ~/Minecraft/bedrock-server-oracle/restore
./restore.sh path/to/your-backup.zip
```

Example:

```bash
cd ~/Minecraft/bedrock-server-oracle/restore
./restore.sh ~/Minecraft/backups/world-backup-20250614-1430.zip
```

---

### 🔍 Verify the Restore

To confirm your world is restored correctly:

- Join your server and check your builds and player location.

- You can also browse the restored files in:

`~/Minecraft/bedrock/worlds/`

---

### 🧪 Want to back up your world before restoring?

See [Uninstall Guide](../uninstall/README.md)
