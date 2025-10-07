#!/usr/bin/env bash
set -euo pipefail

# clean_aux.sh - elimina archivos auxiliares LaTeX en el proyecto
# Uso: ./clean_aux.sh [--yes]  
# Si se pasa --yes, no pide confirmación.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NONINTERACTIVE=false
if [ "${1:-}" = "--yes" ]; then
	NONINTERACTIVE=true
fi

PATTERNS=("*.aux" "*.log" "*.toc" "*.out" "*.lof" "*.lot" "*.fls" "*.fdb_latexmk" "*.synctex.gz" "*.bbl" "*.blg" "*.nav" "*.snm" "*.ilg" "*.idx")

echo "Buscando archivos auxiliares en: $ROOT_DIR"
FOUND=()
for p in "${PATTERNS[@]}"; do
	while IFS= read -r -d $'\0' f; do
		FOUND+=("$f")
	done < <(find "$ROOT_DIR" -type f -name "$p" -print0 2>/dev/null || true)
done

if [ ${#FOUND[@]} -eq 0 ]; then
	echo "No se encontraron archivos auxiliares."
	exit 0
fi

echo "Archivos encontrados (${#FOUND[@]}):"
for f in "${FOUND[@]}"; do
	printf "  %s\n" "$f"
done

if ! $NONINTERACTIVE; then
	read -r -p "¿Deseas eliminar estos archivos? [y/N] " REPLY
	if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
		echo "Cancelado por el usuario. Ningún archivo fue eliminado."
		exit 0
	fi
fi

echo "Eliminando..."
for f in "${FOUND[@]}"; do
	rm -v -- "$f" || true
done

echo "Eliminación completada."
