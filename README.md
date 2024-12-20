# One Repo to Rule Them All
Useful bioinformatics scripts and commands

### ```avg_gene_depth.sh```
[Bash script](avg_gene_depth.sh)

Calculate the average sequencing depth per gene in a BAM file from a **transcriptome alignment**
```
Usage: bash avg_gene_depth.sh BAM_INPUT > OUT_FILE

Help:
  -h      Print this help message
```

### ```avg_read_length.sh```
[Bash script](avg_read_length.sh)

Get the average read length per gene/feature in a BAM file

### ```split_bam.sh```
[Bash script](split_bam.sh)

Split a BAM file into a specified number of files or a specified number of reads per file
```
Usage: bash split_bam.sh -b <BAM_FILE> [-n NUMBER_OF_FILES | -r NUMBER_OF_READS_PER_FILE]

Required:
  -b      BAM file input
  -n|-r   Use -n to specify total number of files, or -r to specify number of reads per file
Optional:
  -p      Specify prefix for output bam files (default: bam_split)
  -h      Print this help message
```
