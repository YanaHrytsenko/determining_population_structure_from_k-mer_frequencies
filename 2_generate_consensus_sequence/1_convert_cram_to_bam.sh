#!/bin/bash

#module load SAMtools/1.12-GCC-10.2.0
#module load BCFtools/1.12-GCC-10.2.0


PTH="" #path to .cram files

FILELIST=( $( find $PTH -maxdepth 1 -name "*.cram" |sort) )

ARRLEN=${#FILELIST[@]}

for (( i = 0; i < $ARRLEN; i++ ))
do

    sample_cram="${FILELIST[i]}"

    NEWNAME=$(echo ${FILELIST[i]} | sed 's/cram/bam/g')

    sample_bam="$NEWNAME"

    ref_seq_fa="GRCh38_full_analysis_set_plus_decoy_hla.fa"

    samtools view -b -T ${ref_seq_fa} -o ${sample_bam} ${sample_cram}

done
