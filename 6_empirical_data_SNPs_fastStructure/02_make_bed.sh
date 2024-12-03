#!/bin/bash
#SBATCH --job-name="make_bed"
#SBATCH --time=10:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=36   # processor core(s) per node
#SBATCH --mail-user="rsschwartz@uri.edu" #CHANGE TO user email address
#SBATCH --mail-type=ALL
#SBATCH --array=[2-5]%4 # CHANGE this second bracketed number to the total jobs you need(taxa-1); CHANGE after % to number of  simultaneous jobs
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err

cd $SLURM_SUBMIT_DIR

module purge
module load PLINK/2.00a3.7-gfbf-2023a

VCF=merged${SLURM_ARRAY_TASK_ID}.vcf.gz
N=$((SLURM_ARRAY_TASK_ID + 1))

# perform linkage pruning - i.e. identify prune sites
plink --vcf $VCF --double-id \
--set-missing-var-ids @:# \
--indep-pairwise 50 10 0.1 --out fig${N}

# prune and create pca
plink --vcf $VCF --double-id --set-missing-var-ids @:# \
--extract fig${N}.prune.in \
--make-bed --pca --out fig${N}
