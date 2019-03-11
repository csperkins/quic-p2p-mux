VERSION = 00

DRAFTS = draft-perkins-quic-p2p-mux-$(VERSION).pdf \
         draft-perkins-quic-p2p-mux-$(VERSION).txt 

all: $(DRAFTS)

%.txt: %.xml
	@echo "*** generate $< -> $@"
	@xml2rfc $<
	@egrep -ns --colour "\\bmust|required|shall|should|recommended|may|optional\\b" $< || true
	@egrep -ns --colour "\\btbd\\b" $< || true
	@egrep -ns --colour "\\bFIXME\\b" $< || true
	@egrep -ns --colour "\\bTODO\\b" $< || true

%.pdf: %.txt
	@echo "*** enscript $< -> $@"
	@enscript -q -lc -f Courier11 -M A4 -p - $< | ps2pdf - $@

clean:
	-rm -f $(DRAFTS)

