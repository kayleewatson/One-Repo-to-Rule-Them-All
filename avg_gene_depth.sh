#!/usr/bin/env bash

### given a bam file, the script will output the average sequencing depth for each gene ###


#usage:
# bash avg_gene_depth.sh in.bam > out.txt

samtools depth -a $1 > output.txt

awk '
    NR>1{
        arr[$1]   += $3
        count[$1] += 1
    }
    END{
        for (a in arr) {
            print a "\t" arr[a] / count[a]
        }
    }
' output.txt
