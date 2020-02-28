| m colCount j |
" 377 individuals "
m := Array2D rows: 376 columns: 48482.
'affy_Bos1_3728698133.txt' asFileReference readStreamDo: [ : readStream |
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
m dumpTo: 'affy_Bos1_3728698133.ped'.
