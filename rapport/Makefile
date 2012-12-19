FILE=rapport
all:
	pdflatex -interaction nonstopmode $(FILE).tex
	bibtex $(FILE).aux
	pdflatex -interaction nonstopmode $(FILE).tex
	pdflatex -interaction nonstopmode $(FILE).tex
