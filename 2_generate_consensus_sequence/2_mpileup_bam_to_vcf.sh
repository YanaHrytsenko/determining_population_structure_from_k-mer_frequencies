#!/bin/bash

#module load SAMtools/1.12-GCC-10.2.0
#module load BCFtools/1.12-GCC-10.2.0

PTH="" #path to .bam files

FILELIST=( $( find $PTH -maxdepth 1 -name "*.bam" |sort) )

ARRLEN=${#FILELIST[@]}

for (( i = 0; i < $ARRLEN; i++ ))
do
    bam_file="${FILELIST[i]}"

    NEWNAME=$(echo ${FILELIST[i]} | sed 's/bam/vcf/g')


    vcf_output_file="$NEWNAME"

    ref_seq="GRCh38_full_analysis_set_plus_decoy_hla.fa"

    #without filtering step
    #bcftools mpileup -Ou -f ${ref_seq} ${bam_file} | bcftools call -Ou -mv -o ${vcf_output_file}

    #with filtering step
    bcftools mpileup -Ou -f ${ref_seq} ${bam_file} | bcftools call -Ou -mv | bcftools filter -s LowQual -e '%QUAL<20 || DP>60' > ${vcf_output_file}

done
