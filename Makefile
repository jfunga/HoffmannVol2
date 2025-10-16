# Makefile — atajos reproducibles
TEX=latexmk
MAIN=main.tex

.PHONY: all build clean distclean watch build-es build-en _compile

all: build

build: build-es

watch:
	$(TEX) -pvc -silent

clean:
	$(TEX) -c
	rm -f out/*.synctex.gz || true

distclean: clean
	rm -rf out/*

# ===== Bilingüe (se activará en el Paso 2) =====
build-es:
	BOOKLANG=es $(MAKE) _compile

build-en:
	BOOKLANG=english $(MAKE) _compile

_compile:
	@echo "Compilando con idioma=$(BOOKLANG)"
	echo "% auto wrapper" > __langwrap.tex
	echo "\\def\\booklang{$(BOOKLANG)}" >> __langwrap.tex
	echo "\\input{main.tex}" >> __langwrap.tex
	latexmk -silent __langwrap.tex
	@mkdir -p out
	@mv -f out/__langwrap.pdf out/main-$(BOOKLANG).pdf || true
	@rm -f __langwrap.tex
