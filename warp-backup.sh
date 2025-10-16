#!/bin/zsh
# Backup y push rápido del proyecto HoffmannVol2
cd /Users/javierfungairino/Desktop/HoffmannVol2 || exit
ts=$(date +"%Y-%m-%d %H:%M:%S")
msg=${1:-"Backup automático — $ts"}
echo "🧭 Guardando snapshot: $msg"
git add .
git commit -m "$msg"
git push
echo "✅ Backup completado y enviado a GitHub"
