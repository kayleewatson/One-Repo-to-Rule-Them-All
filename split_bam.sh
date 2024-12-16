#!/usr/bin/env bash

prefix=bam_

Help()
{
    echo
    echo "This script will split a BAM file into multiple files, maintaining the order of the reads in the original file"
    echo
    echo "Usage: bash split_bam.sh -b <BAM_FILE> [-n NUMBER_OF_FILES | -r NUMBER_OF_READS_PER_FILE]"
    echo
    echo "Required:"
    echo "  -b      BAM file input"
    echo "  -n|-r   Use -n to specify total number of files, or -r to specify number of reads per file"
    echo "Optional:"
    echo "  -p      Specify prefix for output bam files (default: bam_split)"
    echo "  -h      Print this help message"
}


while getopts ":s:b:n:r:p:h" option; do
    case $option in
    b)
        bam=$OPTARG;;
    n)
        num_files=$OPTARG;;
    r)
        num_reads=$OPTARG;;
    p)
        pre=$OPTARG;;
    h)
        Help
        exit;;
    \?)
        echo "Error: Invalid option"
        exit;;
    esac
done

if [[ ! -z $pre ]]; then
    prefix="$pre"_split
    #prefix="test_"
fi

numeric="^[0-9]+$"

numeric="^[0-9]+$"

if [[ -z $bam ]]; then
    echo "BAM file input required"
    exit
else
    if [[ -z $num_files ]]; then
        if [[ -z $num_reads ]]; then
            echo -e "\nPlease specify number of files or number of reads per file"
            exit
        elif ! [[ $num_reads =~ $numeric ]]; then
            echo -e "\nNumber of reads must be an integer"
            exit
        else
            echo -e "\nSplitting bam input into individual files with $num_reads reads each\n"
            samtools view $bam | split -l $num_reads -d - $prefix
            exit
        fi
     elif ! [[ $num_files =~ $numeric ]]; then
        echo -e "\nNumber of files must be an integer"
        exit
     else
         echo -e "\nSplitting bam input into $num_files individual files\n"
         samtools view $bam > temporary_file_for_split_1.sam
         split -n l/$num_files -d temporary_file_for_split_1.sam $prefix
         rm temporary_file_for_split_1.sam
    fi
fi

samtools view -H $bam > split_header_temp_file
for file in $prefix*; do
    cat split_header_temp_file "$file" | samtools view -bh > "$file".bam
    rm "$file"
done
rm split_header_temp_file
