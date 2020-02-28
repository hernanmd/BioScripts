| workingPath excludedSNPFiles finalReportCNV excludedSNPCol newFinalReportCNV |

workingPath := 'c:\Hernan\Por-Usuario\Silvina - Claudia\'.
finalReportCNV := workingPath , 'IGEVET_EQN65KV02_20170605_FinalReportCNV.csv'.
excludedSNPCol := workingPath , 'EQN65kCAR.removed.snps'.
newFinalReportCNV := workingPath , 'IGEVET_EQN65KV02_20170605_FinalReportCNV.filtered.2.csv'.

finalReportCNV asFileReference readStreamDo: [ : stream |
    | reader excludedSNPs filteredFinalReportCNV |
    reader := (NeoCSVReader on: stream)
            separator: $,;
            yourself.
    10 timesRepeat: [ reader skipHeader ].
    excludedSNPs := excludedSNPCol asFileReference contents lines.
    newFinalReportCNV asFileReference writeStreamDo: [ : writeStream |
        | writer |
        writer := (NeoCSVWriter on: writeStream)
            fieldWriter: #raw;
            separator: $,;
            writeHeader: #('SNP Name' 'Sample ID' 'B Allele Freq' 'Log R Ratio');
            yourself.
        reader do: [ : row |
            (excludedSNPs includes: row first)
                ifFalse: [ writer nextPut: row ] ].
        writer flush ] ].
