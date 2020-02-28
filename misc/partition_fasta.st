| fastapath inputBasename outputBasename |
fastapath := 'c:\Users\mvs\Downloads\clpNGS.fasta'.
inputBasename := fastapath asFileReference basenameWithoutExtension.
outputBasename := inputBasename , '_part_'.
((BioParser parseMultiFastaFile: fastapath) partitionBy: 2) doWithIndex: [ : fmr : index | 
		fmr dumpToStream: (outputBasename , index asString) asFileReference writeStream ].