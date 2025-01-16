#!/bin/bash
# Laura Dean
# 15/1/25
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50g
#SBATCH --time=24:00:00
#SBATCH --job-name=stickle_flt_vcf
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
  
############################
   # PREPARE ENVIRONMENT #
############################

# set variables
wkdir=/gpfs01/home/mbzlld/data/stickleback
species=stickleback
VCF=$wkdir/vcfs/${species}_SNPs.vcf.gz

# load modules
module load vcftools-uoneasy/0.1.16-GCC-12.3.0
module load bcftools-uoneasy/1.18-GCC-13.2.0

###################
# Filter vcf file #
###################

# remove missing data
vcftools \
--gzvcf $VCF \
--max-missing 1 \
--recode \
--recode-INFO-all \
--stdout |
bcftools view -Oz -o ${VCF%.*.*}_nomissing.vcf.gz
bcftools index ${VCF%.*.*}_nomissing.vcf.gz


# unload modules
module unload vcftools-uoneasy/0.1.16-GCC-12.3.0
module unload bcftools-uoneasy/1.18-GCC-13.2.0

