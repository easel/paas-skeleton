.PHONY: docs
docs: build/docs.html

build/docs.html: docs/index.asc docs/*/* docs/*/*/*
	asciidoctor -o $@ docs/index.asc

%.svg: %.gv
	dot -Tsvg $< > $@
