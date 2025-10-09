# 📘 HoffmannVol2 — Volumen 2 (LaTeX)

Proyecto en LaTeX del **Volumen 2** de la colección *Math Hoffmann*.

## Estructura
HoffmannVol2/
├─ apertura/ # Secciones iniciales (portada, créditos, etc.)
├─ chapters/ # Capítulos (.tex)
├─ media/ # Imágenes y recursos
├─ out/ # Compilados (PDF y auxiliares)
│ └─ main.pdf
├─ main.tex # Documento raíz
├─ style.tex # Estilos del libro
├─ clean_aux.sh # Limpieza de auxiliares
├─ DEV_NOTES.md # Notas internas
└─ README.md

## Compilar
```bash
latexmk -pdf -output-directory=out main.tex
# Alternativa:
# pdflatex -output-directory=out main.tex