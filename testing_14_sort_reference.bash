#!/bin/bash
# Laura Dean
# 14/1/25
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --job-name=sort_reference
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out




reference=/gpfs01/home/mbzlld/data/reference_genomes/G_aculeatus/version5-UGA/stickleback_v5_assembly_unsorted.fa
order=/gpfs01/home/mbzlld/data/reference_genomes/G_aculeatus/version5-UGA/stickleback_v5_correct_chr_order.txt

source $HOME/.bash_profile
conda activate seqkit

seqkit grep \
	-f $order \
	-o ${reference%_*}.fa \
	$reference

conda deactivate
