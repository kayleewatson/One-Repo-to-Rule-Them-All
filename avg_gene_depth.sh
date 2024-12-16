#!/usr/bin/env bash

Help()
{
    echo
    echo "Given a bam file, calculate the average sequencing depth for each gene in a TSV format"
    echo
    echo "Usage: bash avg_gene_depth.sh BAM_INPUT > OUT_FILE"
    echo
    echo "Help:"
    echo "  -h      Print this help message"
}


while getopts ":h" option; do
    case $option in
    h)
        Help
        exit;;
    \?)
        echo "Error: Invalid option"
        exit;;
    esac
done

samtools depth -a $1 > temp_depth_output.txt

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
' temp_depth_output.txt

rm temp_depth_output.txt
