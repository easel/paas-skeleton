.PHONY: docs
docs: build/docs.html build/specification.html

build/docs.html: docs/00index.adoc docs/* docs/*/* .paas-skeleton/asciidoc/*
	test -n "$(ASCIIDOC_FILE)" || { echo "not building $@ due to missing asciidoc"; exit 0; } && $(ASCIIDOC_FILE) -o $@ docs/00index.adoc

build/specification.html: docs/specification.adoc .paas-skeleton/asciidoc/*
	test -n "$(ASCIIDOC_FILE)" || { echo "not building $@ due to missing asciidoc"; exit 0; } && $(ASCIIDOC_FILE) -o $@ docs/specification.adoc

docs/specification.adoc:
	if [ ! -e docs/specification.adoc ]; then cp -v .paas-skeleton/asciidoc/specification.adoc docs/specification.adoc; fi

%.svg: %.gv
	dot -Tsvg $< > $@
