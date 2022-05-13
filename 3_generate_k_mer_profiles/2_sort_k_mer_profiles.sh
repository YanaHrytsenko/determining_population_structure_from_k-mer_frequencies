#!/bin/bash

sorted_dir="" #path to store sorted k-mer profiles

#example shown for files of AFR population
for sample in AFR
do

  for k in 21
  do
      k_mer_profile_dir="${sample}_kmer_profiles/${k}_mers/"

      bash sortFAs.sh ${k_mer_profile_dir}

      sorted_kmer_dir="${sorted_dir}/${k}_mers/"

      mv ${k_mer_profile_dir}*_sorted.fa ${sorted_kmer_dir}

  done
done
