#!/bin/bash

set -x
plate1="$1"
plate2="$2"
sortedFile1="tmp_sorted1.txt"
sortedFile2="tmp_sorted2.txt"

extract_affychrpos () {
	# $1 = Report txt exported file
	# $2 = Output file name

	# Get the number of fields
	nftotal=$(tail -n +7 "$1" | awk -F'\t' '{print NF; exit}')
	# Get the number of field of Chr_id column
	nfchr="$(($nftotal - 2))"
	# Get the number of field of Start (position) column
	nfpos="$(($nftotal - 1))"
	# Cut fields and sort the column
	tail -n +7 "$1" | cut -f1,"$nfchr","$nfpos" | sort -t $'\t' -k2n,3n -o "$2"
	# Join the columns
	# paste "$2" "$3"
}

extract_affychrpos $plate1 $sortedFile1
# Remove two empty lines at beggining
#tmp1="tmp_sorted_plate1.txt"
#tail -n +3 $sortedFile1 > $tmp1

extract_affychrpos $plate2 $sortedFile2

comm --nocheck-order --output-delimiter="\t" --total -12 $sortedFile1 $sortedFile2 > affyPlateIds_comunes.txt
