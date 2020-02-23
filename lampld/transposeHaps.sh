#!/bin/sh
# Script to transpose the HAPS format into REF format required by LAMP-LD

inputFile=$1
outputFile="$inputFile.out"

echo -n "Remove columns..."
cut -d" " -f 5- "$inputFile" > "$outputFile.t1"
echo ok

echo -n "Transpose matrix..."
awk '{for (i=1; i<=NF; i++) a[i]=a[i](NR!=1?FS:" ")$i} END {for (i=1; i in a; i++) print a[i]}' "$outputFile.t1" > "$outputFile.t2"
echo "ok"
