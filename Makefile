all: results/moby_dick.csv results/jane_eyre.csv

# Regenerate results for "Moby Dick"
results/moby_dick.csv: data/moby_dick.txt
	python bin/countwords.py data/moby_dick.txt > results/moby_dick.csv

results/jane_eyre.csv: data/jane_eyre.txt
	python bin/countwords.py data/jane_eyre.txt > results/jane_eyre.csv


clean:
	rm -f results/*.csv