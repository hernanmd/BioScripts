#!/bin/bash

for bedFile in $(ls *.bed)
do
	echo ${bedFile%%.*}
	./shapeIt2.sh ${bedFile%%.*}
done
