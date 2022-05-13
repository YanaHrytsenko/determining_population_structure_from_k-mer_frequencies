#!/bin/bash

#module load Python/3.6.6-foss-2018b
#module load Jellyfish/2.2.10-foss-2018b



for k in 21
do
   kmer_prof_dir="${k}_mers/"

   mkdir ${kmer_prof_dir}

   #example shown for files of AFR population
   for sample in AFR_ACB_1_female_HG01886 AFR_ACB_2_female_HG02012 AFR_ACB_3_female_HG02282 AFR_ACB_4_male_HG02314 AFR_ACB_5_male_HG01882 AFR_ACB_6_male_HG02317
   do

       sample_file="${sample}_consensus.fa"
       jf_file="${kmer_prof_dir}${sample}_${k}_mers.jf"
       fa_file="${kmer_prof_dir}${sample}_${k}_mers.fa"

       jellyfish count ${sample_file} -m ${k} -s 100M -t 50 -L 2 -C --disk -o ${jf_file}

       jellyfish dump ${jf_file} > ${fa_file} -c

       rm ${jf_file}

   done

done
