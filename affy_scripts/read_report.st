| m colCount j |
m := Array2D rows: 753 columns: 48482.
'affy_ArBos1_3728697113.txt' asFileReference readStreamDo: [ : readStream |
	| i |
	i := 1.
	(NeoCSVReader on: readStream) 
		separator: Character tab;
"		skipHeader;"
		rowsDo: [: row | 
			| tRow |
			tRow := (BioGenotypeCollection fromAlleles: row) spaceAlleles
				ifEmpty: [ row ]
				ifNotEmpty: [ : arg | 
					Array streamContents: [ : a | 
						a 
							nextPutAll: (row first: 3);
							nextPutAll: arg ] ].
			m
				atColumn: i
				put: tRow.
			i := i + 1 ] ].
m dumpTo: 'affy_ArBos1_3728697113.tr'.
