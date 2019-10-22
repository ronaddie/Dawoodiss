.SUFFIXES : .dvi .tex .bbl .ind .aux .oldaux .html .ps .m .eps .pdf .bsh .c .pl .java .class .glo .gls .idx .glo .gls .dia .xml .Snw
# PRESERVE the following lines when applying newpaper
TEX1FILES = dawoodiss.tex literature.tex stakeholderanalysis.tex introduction.tex
TEX2FILES = 
TEXFILES = $(TEX1FILES) $(TEX2FILES)
BIBFILES = dawoodiss.bib
BBLFILES = dawoodiss.bbl
SRCFILES = $(TEXFILES) makefile $(BIBFILES) $(BBLFILES)
TEMPLATEDIR = ${templatesdir}
BINDIR = ${HOME}/bin
DOCFILES = README
GRAPHICSFILES = README
TGZFILES = $(SRCFILES) $(GRAPHICSFILES) $(BIBFILES)
EXPORTFILES = $(TEXFILES) $(BBLFILES) $(DOCFILES) $(BIBFILES) dawoodiss
EXPORTFILES2 = dawoodiss.tgz
MINIEXPORTFILES = dawoodiss.pdf dawoodiss.html dawoodiss
GENERATEDFILES = dawoodiss.log dawoodiss.ps dawoodiss.aux \
                 dawoodiss.pdf dawoodiss.tgz \
                 dawoodiss.minitgz makefile.new dawoodiss.blg \
                 dawoodiss.bbl dawoodiss.tex~ dawoodiss.oldaux \
                 makefilehelp ftpcmds makefile.template .CODE
BINFILES =
TEMPLATEFILES =
ZIPFILES = dawoodiss.tex
ZIPBFILES = dawoodiss.pdf
STYLEFILES = 
EXPORTHOST = probus
EXPORTDIR = dissertation
EXPORTSITE = $(EXPORTHOST):$(EXPORTDIR)
EXPORTDIR2 = dissertation/courseteam
EXPORTSITE2 = $(EXPORTHOST):$(EXPORTDIR2)
REEXPORTHOST = probus
REEXPORTDIR = dissertation
REEXPORTSITE = $(REEXPORTHOST):$(REEXPORTDIR)
MINIEXPORTDIR = dissertation
MINIEXPORTSITE = $(EXPORTHOST):$(MINIEXPORTDIR)
EXPORTCMD = rsync -a -L -e ssh
REEXPORTCMD = scp -r
# POSTEXPORTCMD = ssh $(EXPORTHOST) "cd $(EXPORTDIR) ; make reexport"
POSTEXPORTCMD = 
INSTALLCMD = cp
MKFRAMES = mkframes3.pl -p ~/units/64428/sguide/toctop.html -q ~/units/64428/sguide/tocbot.html -P "</font><p><font size=-1>" -l -r -h 0 -b
BINDIR = $(HOME)/bin
TEMPLATEDIR = $(templatesdir)
# LATEX2HTMLCMD = "tth -p~/tthinputs -L$*"
LATEX2HTMLCMD = latex2html -show_section_numbers -split 3 -toc_stars -toc_depth 4 -link 4 -t TOP
ICONDIR = /usr/local/src/latex2html/icons.gif
ICONFILES =  blueball.gif change_begin.gif change_begin_right.gif \
change_delete.gif change_delete_right.gif change_end.gif change_end_right.gif \
contents.xbm contents_motif.gif cross_ref_motif.gif foot_motif.gif \
greenball.gif icons.html image.gif index_motif.gif invis_anchor.xbm \
lucy_left.gif lucy_left_gr.gif lucy_right.gif lucy_right_gr.gif \
lucy_up.gif lucy_up_gr.gif next_group_motif.gif next_group_motif_gr.gif \
next_motif.gif next_motif_gr.gif orangeball.gif pinkball.gif \
previous_group_motif.gif previous_group_motif_gr.gif  previous_motif.gif \
previous_motif_gr.gif purpleball.gif redball.gif up_motif.gif \
up_motif_gr.gif whiteball.gif yellowball.gif
ICONDIR = /usr/local/src/latex2html/icons.gif
all: dawoodiss.pdf  
# UPDATE the following lines when running newpaper
allpdfs:
	for f in *.eps ; \
	do make `echo $$f | sed 's/eps/pdf/'` ; \
	done
clean:
	rm -rf $(GENERATEDFILES)
	rm *.aux *ans* *old* *.ind *.inx *.out
update:
	cvs update
release:
	cd $parentdir ;\
	cvs release -d $dir
commit:
	cvs commit
help:
	less makefilehelp
print: dawoodiss.ps 
	lpr dawoodiss.ps
mpage: dawoodiss.ps
	mpage -1 -o -t -P -dp -m0 dawoodiss.ps
xview: dawoodiss.pdf
	evince dawoodiss.pdf &
xviewans: dawoodiss_ans.pdf
	evince dawoodiss_ans.pdf &
view: dawoodiss.pdf
	evince dawoodiss.pdf &
dawoodiss_ans.tex: dawoodiss.tex
	sed -e 's/ansfalse/anstrue/g' < dawoodiss.tex > dawoodiss_ans.tex 
dawoodiss.ps: dawoodiss.pdf
dawoodiss.html: dawoodiss.aux $(TEX1FILES) dawoodiss.bbl .latex2html-init
dawoodiss.bbl: $(TEX1FILES) $(BIBFILES)
dawoodiss.pdf: $(TEX1FILES) $(BIBFILES) $(GRAPHICSFILES) dawoodiss.aux dawoodiss.ind
dawoodiss.tgz: $(TGZFILES)
	tar -czvf dawoodiss.tgz $(TGZFILES)  
dawoodiss.minitgz: $(SRCFILES)
	tar -czvf dawoodiss.minitgz $(SRCFILES) 
dawoodiss.zip: $(ZIPFILES)  $(ZIPBFILES)
	if [ -f dawoodiss.zip ] ; then \rm dawoodiss.zip ; fi
	zip -l dawoodiss.zip $(ZIPFILES) 
	zip dawoodiss.zip $(ZIPBFILES)
reexport: $(EXPORTFILES)  
	ssh $(REEXPORTHOST) "bash -c \"if [ -d $(REEXPORTDIR) ] ; then echo 'Directory exists' ; else mkdir -p $(REEXPORTDIR) ; fi\""
	$(REEXPORTCMD) index.tgz $(EXPORTFILES) makefile $(REEXPORTSITE)
export: $(EXPORTFILES) dawoodiss.ps  \
        dawoodiss.pdf  dawoodiss.html 
	ssh $(EXPORTHOST) "bash -c \"if [ -d $(EXPORTDIR) ] ; then echo 'Directory exists' ; else mkdir -p $(EXPORTDIR) ; fi\""
	$(EXPORTCMD) dawoodiss.tgz $(EXPORTFILES) dawoodiss.pdf makefile \
              dawoodiss.html $(EXPORTSITE)
	$(POSTEXPORTCMD) 
miniexport: $(MINIEXPORTFILES)
	ssh $(EXPORTHOST) "bash -c \"if [ -d $(MINIEXPORTDIR) ] ; then echo 'Directory exists' ; else mkdir -p $(MINIEXPORTDIR) ; fi\""
	$(EXPORTCMD) $(MINIEXPORTFILES) $(MINIEXPORTSITE)
	$(POSTEXPORTCMD) 
install:
	$(INSTALLCMD) $(BINFILES) $(BINDIR)
	$(INSTALLCMD) $(TEMPLATEFILES) $(STYLEFILES) $(TEMPLATEDIR)
.m.eps:
	matlab -display 0 < $< 
.m.pcm: 
	vis -uo < $< > $@
.aux.oldaux:
	latex $*
	chkdiff $*
.pdf.ps:
	pdftops $*.pdf
.tex.ps: $< $*.aux
	pdflatex $<
	if ! chkdiff $* ; then pdflatex $< ; fi
	if ! chkdiff $* ; then pdflatex $< ; fi
	chkdiff $*
	pdftops $*.pdf
.tex.dvi: $< $*.aux
	chngpdftex.pl $< $*.XXDVIXX
	cp $< $*.XXSAVEPDFXX
	mv $*.XXDVIXX $<
	latex $<
	chkdiff $*
	mv $*.XXSAVEPDFXX $<
.idx.ind:
	makeindex < $< > $@
.aux.bbl:
	if grep "^\\\\bibliography" $*.tex ; then bibtex $* ; fi
.tex.html:
	$(LATEX2HTMLCMD) $*
	( cd $* ; rm -f $(GRAPHICSFILES) )
	for f in $(GRAPHICSFILES) ; \
	do ln -s /home/addie/usq/pg/PhD/Dawood/dissertation/$$f $*/$$f ; \
	done
	if [ ! "$(ICONFILES)" = "" ] ; \
	then ( cd $* ; rm -f $(ICONFILES) ) ; \
	( cd $(ICONDIR) ; cp $(ICONFILES) /home/addie/usq/pg/PhD/Dawood/dissertation/$* );\
	fi
	touch $*.html
	cd $* ;\
	replace "< Objectives" "Objectives" $*.html index.html ;\
	$(MKFRAMES) ;\
	if [ -f node1.html ] ;\
	then replace "< Objectives" "Objectives" node*.html ;\
	fi
.xml.tex: $<
	mkgoodsb -f $<
	for f in /home/addie/good/tmp/stage3.tex ; \
		do eval `echo "cp $$f $$f" | sed 's/\/home\/addie\/good\/tmp\//GOOD/' | sed "s/\/home\/addie\/good\/tmp\/stage3/$*/" | sed 's/GOOD/\/home\/addie\/good\/tmp\//'` ; \
		done ; \
	overwrite $*.tex /usr/bin/perl -n -e '$$_ =~ s/\\Img{(.*)\.eps}/\\Img{$$1.pdf}/;' -e 'print;' < $*.tex
.tex.pdf: $< $*.aux
	pdflatex $<
	if ! chkdiff $* ; then pdflatex $< ; fi
	if ! chkdiff $* ; then pdflatex $< ; fi
	chkdiff $*
.tex.bsh: $<
	tex2bash $*
.tex.pl: $<
	tex2bash $*.tex $*.pl
.eps.pdf: $<
	epstopdf $<
.tex.aux:
	touch $*.aux
.tex.oldaux:
	touch $*.oldaux
.tex.idx:
	touch $*.idx
.dia.eps:
	dia -e $*.eps $<
.Snw.tex: $<
	Rscript -e "Sweave(\"$<\")"
