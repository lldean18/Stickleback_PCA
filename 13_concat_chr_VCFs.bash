#!/bin/bash
# Laura Dean
# 13/1/25
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=20g
#SBATCH --time=100:00:00
#SBATCH --job-name=stickle_cat_vcfs
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out
  
############################
   # PREPARE ENVIRONMENT #
############################

# set variables
wkdir=/gpfs01/home/mbzlld/data/stickleback
species=stickleback

# load modules
module load bcftools-uoneasy/1.18-GCC-13.2.0

#########################
# Concatenate vcf files #
#########################

# write a list of files to be concatenated (have to escape the ls command for Augusta as I have an alias for it)
ls $wkdir/vcfs/*.vcf.gz > ~/code_and_scripts/File_lists/${species}_ChrLevelVcfFileList.txt

# Concatenate individual chromosome level VCF files
bcftools concat \
--file-list /gpfs01/home/mbzlld/code_and_scripts/File_lists/${species}_ChrLevelVcfFileList.txt \
-o $wkdir/vcfs/${species}.vcf.gz \
-O z \
--threads 32

# index the concatenated VCF file
bcftools index $wkdir/vcfs/${species}.vcf.gz
tabix -p vcf $wkdir/vcfs/${species}.vcf.gz

#####################
# VARIANT FILTERING #
#####################

# Extract only the SNPs from the VCF file (as it contains indels as well)
bcftools view -v snps $wkdir/vcfs/${species}.vcf.gz -O z -o $wkdir/vcfs/${species}_SNPs.vcf.gz

# Index the SNP only VCF file
bcftools index $wkdir/vcfs/${species}_SNPs.vcf.gz
tabix -p vcf $wkdir/vcfs/${species}_SNPs.vcf.gz

# unload module
module unload bcftools-uoneasy/1.18-GCC-13.2.0

