#!/bin/bash
# Laura Dean
# 15/1/25
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10g
#SBATCH --time=5:00:00
#SBATCH --job-name=vcf_summarise
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
  
############################
   # PREPARE ENVIRONMENT #
############################

# set variables
wkdir=/gpfs01/home/mbzlld/data/stickleback
species=stickleback
VCF=$wkdir/vcfs/${species}_SNPs_nomissing.vcf.gz

# load modules
module load bcftools-uoneasy/1.18-GCC-13.2.0


# generate a list of the quality scores to plot in R & decide QUAL filter
#bcftools query \
#-f '%QUAL\n' \
#$VCF > ${VCF%.*.*}_QUAL.txt


# generate a list of the info depth to plot in R & decide on filter
# this is the total depth at each site across all individuals
#bcftools query \
#-f '%DP\n' \
#$VCF > ${VCF%.*.*}_DP.txt


# unload modules
module unload bcftools-uoneasy/1.18-GCC-13.2.0


# plot histograms with python
source $HOME/.bash_profile
conda activate python3

python 15.1_plot_histogram.py ${VCF%.*.*}_QUAL.txt
python 15.1_plot_histogram.py ${VCF%.*.*}_DP.txt

conda deactivate



