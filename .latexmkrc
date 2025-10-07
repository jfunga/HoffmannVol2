# ==============================================
# LATEXMK CONFIG — Usa XeLaTeX y suprime warnings falsos
# ==============================================

$pdf_mode = 1;
$pdflatex = 'xelatex -interaction=nonstopmode -synctex=1 %O %S';

# --- Ignorar advertencias de "end occurred inside a group"
@default_excluded_warnings = ('end occurred inside a group');

# --- Forzar visualización del PDF final automáticamente
$pdf_previewer = 'open';

