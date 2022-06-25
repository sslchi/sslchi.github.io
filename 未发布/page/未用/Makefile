DOCS=index soft conventions Gibbs nspde_chap2 nspde_chap3 nspde reading footer

HDOCS=$(addsuffix .html, $(DOCS))
HDOCS=$(addprefix sources/,$(HDOCS))
HHDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix pages/, $(HHDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	# insert code for copying to server here.
	@echo ' done.'

pages/%.html : %.jemdoc MENU
	jemdoc -o $@ -c jemdoc.conf $<

.PHONY : clean
clean :
	-rm -f pages/*.html
