| m colCount j |
m := Array2D rows: 48483 columns: 3.
'affy_Bos1_3728698133.tmap' asFileReference readStreamDo: [ : readStream |
	| i |
	i := 1.
	(NeoCSVReader on: readStream) 
		separator: Character tab;
"		skipHeader;"
		rowsDo: [: row | 
			m
				atColumn: i
				put: row.
			i := i + 1 ] ].
m dumpTo: 'affy_Bos1_3728698133.map'.
