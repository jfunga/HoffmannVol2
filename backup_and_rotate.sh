#!/usr/bin/env bash
set -euo pipefail

# backup_and_rotate.sh
# Crea un tar.gz del proyecto BackupA (excluye out/ excepto out/main.pdf si existe)
# Mantiene sólo las últimas 2 copias en ~/Desktop/BackupA_backups

BACKUP_ROOT="$HOME/Desktop/BackupA"
BACKUP_DIR="$HOME/Desktop/BackupA_backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TMP_TAR=$(mktemp -t backupA_XXXXXX).tar
DEST="$BACKUP_DIR/BackupA_withPDF_${TIMESTAMP}.tar.gz"

cd "$(dirname "$BACKUP_ROOT")" || exit 1

# Crear tar excluyendo la carpeta out
tar -cf "$TMP_TAR" --exclude="BackupA/out" --exclude="BackupA_backups" BackupA

# Añadir explícitamente el PDF si existe
if [ -f "BackupA/out/main.pdf" ]; then
  tar -rf "$TMP_TAR" BackupA/out/main.pdf
fi

# Comprimir y limpiar temporal
gzip -c "$TMP_TAR" > "$DEST"
rm -f "$TMP_TAR"

printf "Backup creado: %s\n" "$DEST"
ls -lh "$DEST" || true
printf "SHA256:\n"
shasum -a 256 "$DEST" || true

# Mantener sólo las últimas 2 copias
cd "$BACKUP_DIR" || exit 1
OLD=$(ls -1t BackupA*.tar.gz 2>/dev/null | sed -n '3,$p' || true)
if [ -n "$OLD" ]; then
  echo "Eliminando backups antiguos:";
  printf "%s\n" "$OLD" | xargs -I{} rm -v -- "{}" || true
fi

printf "Backups actuales:\n"
ls -lh | sed -n '1,200p'
#!/usr/bin/env bash
set -euo pipefail

# backup_and_rotate.sh
# Crea un tar.gz del proyecto BackupA (excluye out/ excepto out/main.pdf si existe)
# y mantiene solo la copia más reciente en ~/Desktop/BackupA_backups

BACKUP_ROOT="$HOME/Desktop/BackupA"
BACKUP_DIR="$HOME/Desktop/BackupA_backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TMP_TAR=$(mktemp -t backupA_XXXXXX).tar
DEST="$BACKUP_DIR/BackupA_withPDF_${TIMESTAMP}.tar.gz"

cd "$(dirname "$BACKUP_ROOT")" || exit 1

# Crear tar excluyendo la carpeta out
tar -cf "$TMP_TAR" --exclude="BackupA/out" --exclude="BackupA_backups" BackupA

# Añadir explícitamente el PDF si existe
if [ -f "BackupA/out/main.pdf" ]; then
  tar -rf "$TMP_TAR" BackupA/out/main.pdf
fi

# Comprimir y limpiar temporal
gzip -c "$TMP_TAR" > "$DEST"
rm -f "$TMP_TAR"

printf "Backup creado: %s\n" "$DEST"
ls -lh "$DEST" || true
printf "SHA256:\n"
shasum -a 256 "$DEST" || true

# Borrar backups previos (conservar solo el nuevo)
find "$BACKUP_DIR" -maxdepth 1 -type f -name "BackupA*.tar.gz" ! -path "$DEST" -print -delete || true

printf "Backup finalizado. Contenido de %s:\n" "$BACKUP_DIR"
ls -lh "$BACKUP_DIR" || true
