library(BSgenome)
seed_files <- system.file("extdata", "IGEVET", package="BSgenome")

seqnames <- paste(
	"chr", 
	c(1:20, "X", "M", "Un", paste(c(1:20, "X", "Un"), "_random", sep="")), 
	sep="")
seqnames <- paste("chr", c(1:20, "X", "M", "Un", sep="")

forgeBSgenomeDataPkg("seed.file.txt")

forgeSeqFiles(
	seqnames, 
	prefix="ce2", 
	suffix=".fa.gz",
    seqs_srcdir=seqs_srcdir,
    seqs_destdir=tempdir(), 
	ondisk_seq_format="2bit")
