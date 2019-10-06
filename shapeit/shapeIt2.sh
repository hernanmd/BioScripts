#!/bin/sh
inputFile=$1
shapeit \
	-B "$inputFile" \
	-O "$inputFile.PHASED" \
	-T 16
