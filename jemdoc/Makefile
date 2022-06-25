DOCS=index wjf gltj  nspde nspde_chap2 nspde_chap3 nspde_conventions
HDOCS=$(addsuffix .html, $(DOCS))
HDOCS=$(addprefix sources,$(HDOCS))
HHDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix ../pages/, $(HHDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	# insert code for copying to server here.
	@echo ' done.'

../pages/%.html : %.jemdoc menu_index menu_nspde
	python jemdoc.py -o $@ -c mysite.conf $<

.PHONY : clean
clean :
	-rm -f pages/*.html
