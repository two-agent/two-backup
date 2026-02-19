# Two Backup System

Auto-backup of OpenClaw workspace to GitHub.

## Quick Start

### First-time setup (create GitHub repo):

Option 1 - Create new repo under your account:
```bash
cd /root/.openclaw/workspace
gh repo create two-backup --public --source=. --remote=origin
./backup.sh
```

Option 2 - Use existing repo:
```bash
cd /root/.openclaw/workspace
git remote add origin https://github.com/YOUR_USERNAME/two-backup.git
git push -u origin master
```

### Backup after changes:
```bash
./backup.sh
```

Or with custom message:
```bash
./backup.sh "Added new project files"
```

### Restore from backup:
```bash
./restore.sh https://github.com/YOUR_USERNAME/two-backup.git
```

## What's backed up

- ✅ Identity files (IDENTITY.md, USER.md, SOUL.md)
- ✅ Memory and workspace files
- ✅ Analysis scripts
- ✅ Project files
- ✅ OpenClaw config (config-backup/openclaw.json)

- ❌ Twitter data export (too large/personal)
- ❌ OpenClaw internal (.openclaw/)
- ❌ Media files

## Automated backups (cron)

To back up every 6 hours:

```bash
crontab -e
```

Add this line:
```
0 */6 * * * cd /root/.openclaw/workspace && ./backup.sh >> /tmp/backup.log 2>&1
```

## Quick commands

```bash
# Check current backup status
git status

# See commit history
git log --oneline

# View changes since last backup
git diff HEAD

# Compare with remote
git diff origin/master
```

## Restoration flow

If something breaks:

1. **Stop OpenClaw** (if running):
   ```bash
   systemctl --user stop openclaw-gateway
   ```

2. **Restore from backup**:
   ```bash
   cd /root/.openclaw/workspace
   ./restore.sh https://github.com/YOUR_USERNAME/two-backup.git
   ```

3. **Restart OpenClaw**:
   ```bash
   systemctl --user start openclaw-gateway
   ```

## Notes

- Backups include workspace files only (not OpenClaw itself)
- You can manually review commits before pushing
- GitHub history preserves all versions (can roll back anytime)
- If `gh` CLI asks for auth, it'll open a browser on your local machine
