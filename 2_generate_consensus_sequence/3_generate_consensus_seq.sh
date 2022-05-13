#!/bin/bash

#module load SAMtools/1.12-GCC-10.2.0
#module load BCFtools/1.12-GCC-10.2.0



PTH="" #path to .vcf files

FILELIST=( $( find $PTH -maxdepth 1 -name "*.vcf" |sort) )

ARRLEN=${#FILELIST[@]}

for (( i = 0; i < $ARRLEN; i++ ))

do

    vcf_file="${FILELIST[i]}"

    NEWNAME=$(echo ${FILELIST[i]} | sed 's/.vcf/.vcf.gz/g')

    zipped_vcf="$NEWNAME"

    bgzip -c ${vcf_file} > ${zipped_vcf}

    tabix -fp vcf ${zipped_vcf}

    NEWNAMEFA=$(echo ${FILELIST[i]} | sed 's/.vcf/_consensus.fa/g')

    consensus_output_file="$NEWNAMEFA"

    zipped_ref_fa="GRCh38_full_analysis_set_plus_decoy_hla.fa.gz"

    zcat ${zipped_ref_fa} | bcftools consensus ${zipped_vcf} > ${consensus_output_file}

done
