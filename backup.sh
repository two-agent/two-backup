#!/bin/bash
# Backup workspace to GitHub
# Run this regularly or set up a cron job

REPO="${REPO:-two-backup}"
MESSAGE="${1:-Auto-backup $(date +%Y-%m-%d\ %H:%M)}"

# Add all changes
git add -A

# Check if there are changes
if git diff --staged --quiet; then
    echo "No changes to commit. Backup up to date."
    exit 0
fi

# Commit
git commit -m "$MESSAGE"

# Push to GitHub
if git remote | grep -q origin; then
    git push origin master
    echo "✓ Backup pushed to GitHub"
else
    echo "⚠️  No remote 'origin' configured. Create a GitHub repo first:"
    echo "   gh repo create two-backup --public --source=. --remote=origin"
    echo "   Or use your own repo:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/two-backup.git"
    echo "   git push -u origin master"
fi
