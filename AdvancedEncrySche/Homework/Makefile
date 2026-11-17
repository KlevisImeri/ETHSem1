LATEXMK ?= latexmk
LATEXMKFLAGS ?= -pdf -interaction=nonstopmode -halt-on-error

.PHONY: all watch

all:
	$(LATEXMK) $(LATEXMKFLAGS) Homework_1-template.tex

watch:
	$(LATEXMK) $(LATEXMKFLAGS) -pvc Homework_1-template.tex
