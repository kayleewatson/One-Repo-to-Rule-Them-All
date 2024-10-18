#!/usr/bin/env bash

### calculate average mapped read length per gene/feature in bam file ###


#usage:
# bash avg_read_length.sh in.bam > out.txt

samtools view -F 4 $1 | awk '{print $3"\t"length($10)}' > output.txt

awk '
    NR>1{
        arr[$1]   += $2
        count[$1] += 1
    }
    END{
        for (a in arr) {
            print a "\t" arr[a] / count[a]
        }
    }
' output.txt
