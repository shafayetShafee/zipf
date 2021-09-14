.PHONY : all clean help settings results

COUNT=bin/countwords.py
COLLATE=bin/collate.py
PLOT=bin/plotcounts.py
PARAMS=bin/plotparams.yml
BOOK_SUMMARY=bin/book_summary.sh
DATA=$(wildcard data/*.txt)
RESULTS=$(patsubst data/%.txt,results/%.csv,$(DATA))
PNGS=$(patsubst data/%.txt,results/%.png, $(DATA))

## all : Regenerate all results.
all : results/collated.png

## results : regenerate result for all book.
results : ${RESULTS}

## wordcount_pngs : regenerate word count plots for all book.
wordcount_pngs : ${PNGS}

## results/collated.png : plot the collated results.
results/collated.png : results/collated.csv $(PARAMS)
	python $(PLOT) $< --outfile $@ --plotparams $(word 2,$^) --style seaborn

## results/collated.csv : collate all results.
results/collated.csv : $(RESULTS) $(COLLATE)
	@mkdir -p results
	python $(COLLATE) $(RESULTS) > $@

## results/%.csv : Regenerate results for any book.
results/%.csv : data/%.txt $(COUNT)
	@bash $(BOOK_SUMMARY) $< Title
	@bash $(BOOK_SUMMARY) $< Author
	python $(COUNT) $< > $@	

## results/%.png : Regenerate word count plot for any book.
results/%.png : results/%.csv $(PLOT) $(PARAMS)
	@mkdir -p results
	python $(PLOT) $< --outfile $@ --plotparams $(word 3,$^) --style seaborn

## clean : remove all generated files.
clean :
	rm -f $(RESULTS) results/collated.csv results/collated.png

## settings : show variable's values.
settings :
	@echo COUNT: $(COUNT)
	@echo DATA: $(DATA)
	@echo RESULTS: $(RESULTS)
	@echo COLLATE: $(COLLATE)
	@echo PLOT: $(PLOT)
	@echo PARAMS: $(PARAMS)
	@echo BOOK_SUMMARY: $(BOOK_SUMMARY)

## help : show this message.
help :
	@grep -h -E "^##" ${MAKEFILE_LIST} | sed -e 's/## //g' | column -t -s ":"