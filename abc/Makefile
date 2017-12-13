.PHONY: all clean

SHELL=/usr/bin/env bash
.SHELLFLAGS = -eufc -o pipefail

.SECONDARY:

TA=taxid_accession.tsv

all: $(TA).complete

$(TA).complete:
	./taxid_accession.sh > $(TA)
	touch $@

clean:
	rm $(TA)

