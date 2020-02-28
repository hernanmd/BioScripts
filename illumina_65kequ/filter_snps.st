| snpMapFile workingDir |

workingDir := 'c:\Hernan\Por-Usuario\Silvina - Claudia\'.
snpMapFile := workingDir , 'SNP_Map.txt' asFileReference.

snpMapFile readStreamDo: [ : stream |
    | reader excludedSNPs filteredFinalReportCNV |
    reader := (NeoCSVReader on: stream)    
            separator: Character tab;
            skipHeader;
            yourself.
    excludedSNPs := workingDir , 'EQN65kCAR.removed.snps' asFileReference contents lines.
    workingDir , 'SNP_Map_filtered.txt' asFileReference writeStreamDo: [ : writeStream |
        | writer |
        writer := (NeoCSVWriter on: writeStream)
            fieldWriter: #raw;
            separator:  Character tab;
            writeHeader: #('Index Name' 'Chromosome' 'Position' 'GenTrain Score' 'SNP' 'ILMN Strand' 'Customer Strand' 'NormID');
            yourself.
        reader do: [ : row |
            (excludedSNPs includes: row second)
                ifFalse: [ writer nextPut: row ] ].
        writer flush ] ].

