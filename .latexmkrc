# .latexmkrc — XeLaTeX + outdir
$out_dir = 'out';
$aux_dir = 'out';

$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory='.$out_dir.' %O %S';
$bibtex   = 'biber %O %B';

$clean_ext = 'acn acr alg aux bbl bcf blg fdb_latexmk fls glo glg gls idx ilg ind ist lof log lol lot lox out run.xml synctex.gz toc xdv';

@default_files = ('main.tex');

$pdf_mode   = 1;
$max_repeat = 5;
$recorder   = 1;
$diagnostics = 1;
