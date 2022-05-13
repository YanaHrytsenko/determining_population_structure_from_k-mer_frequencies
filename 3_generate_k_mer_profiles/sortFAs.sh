#!/bin/bash

#helper function to sort k-mer profiles
 
PTH=$1

FILELIST=( $( find $PTH -maxdepth 1 -name "*.fa" |sort) )
ARRLEN=${#FILELIST[@]}

for (( i = 0; i < $ARRLEN; i++ ))
do
      NEWNAME=$(echo ${FILELIST[i]} | sed 's/.fa/_sorted.fa/g')
      sort ${FILELIST[i]} > $NEWNAME
done
