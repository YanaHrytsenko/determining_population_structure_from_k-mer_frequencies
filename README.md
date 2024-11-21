# Determining population structure from k-mer frequencies
This repository contains all the necessary code to analyze human genome data from different populations and identify population structure from k-mer frequencies found in each genome using principal component analysis (PCA) and K-Means clustering. 


# Introduction
Population stratification using genome sequences often involves analyzing the genetic diversity among populations to identify subgroups or clusters based on genetic similarity. When using k-mers, PCA, and K-Means clustering, the approach involves counting k-mers in each genome, calculating the intersection of k-mer profiles (k-mer and the number of times it is found in the sequence) across all genomes (samples), applying PCA on the k-mer profiles (scaled) to extract principal components (PCs) and applying K-Means clustering algorithm to the first two PCs. See the manuscript cited below for an explanation of how to pick the length of a k-mer, the number of PCs, and the "number of clusters" parameter when applying K-Means method.

# Usage
Each directory is numbered in sequential order of steps to perform population stratification using k-mers.
For reproducibility purposes: 
- Follow the steps in the 1_download_samples directory to download open-source genome sequences (cram format) from different populations from the 1000 Genomes Project and the Human Genome reference sequence.
- Directory 2_generate_consesus_sequence lists the steps to convert the cram files into fasta files from which k-mers will be counted.
- Use directory 3_generate_kmer_profile for step-by-step instructions/scripts on counting k-mers in genome sequences using JellyFish software.
- Apply PCA and K-Means clustering following steps in the 4_PCA_and_clustering directory.
- You can find the outputs from this work in the 5_outputs directory.

# Software packages used  
- SAMtools (version 1.12)
- BCFtools (version 1.12)
- Jellyfish (version 2.2.10)
  
# Python Dependencies
- Python (version 3.6.6)
- pandas (version 1.3)
- numpy (version 1.19)
- matplotlib (version 3.3.3)
- scikit-learn (for StandardScaler, PCA and K-Means) (version 0.23.2)


# Citation
Yana Hrytsenko, Noah M. Daniels, Rachel S. Schwartz et al. Determining population structure from k-mer frequencies., 01 December 2023, PREPRINT [https://doi.org/10.21203/rs.3.rs-1689838/v2]

# License
MIT License

Copyright (c) 2023 Yana Hrytsenko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
