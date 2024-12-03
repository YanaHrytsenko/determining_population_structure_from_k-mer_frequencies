#!/bin/bash
#SBATCH --job-name="var_sites"
#SBATCH --time=100:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=1   # processor core(s) per node
#SBATCH --mail-user="rsschwartz@uri.edu" #CHANGE TO user email address
#SBATCH --mail-type=ALL
#SBATCH --array=[1-22]%22 # CHANGE this second bracketed number to the total jobs you need(taxa-1); CHANGE after % to number of  simultaneous jobs
#SBATCH -o %x_%A_%a.out
#SBATCH -e %x_%A_%a.err

cd $SLURM_SUBMIT_DIR

module purge

module load Biopython/1.83-foss-2023b
module load MAFFT/7.475-gompi-2020b-with-extensions

F=$SLURM_ARRAY_TASK_ID

python ../sims/get_var_sites_from_fasta.py chr${F}/chr${F}_aligned.fasta 

[rsschwartz@ssh3 structure_real_data]$ cat 01_merge_vcf.sh 
#!/bin/bash
#SBATCH --job-name="merge"
#SBATCH --time=100:00:00  # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=36   # processor core(s) per node
#SBATCH --mail-user="rsschwartz@uri.edu" #CHANGE TO user email address
#SBATCH --mail-type=ALL

cd $SLURM_SUBMIT_DIR

module purge
module load BCFtools/1.12-GCC-10.2.0

bcftools merge --missing-to-ref -o merged.vcf.gz /data/schwartzlab/yana/human_VCF_1000_genome_project/WGS_files_from_1000_human_genome_project/vcf_files/*/*.vcf.gz
