#!/bin/bash
# Laura Dean
# 20/11/24

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=40g
#SBATCH --time=15:00:00
#SBATCH --job-name=catFqs
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


################################################################################################################
# BIG DATA with both final repeats: Dec 2024 concatenate runs for each individual into new properly named .fastq.gz files
################################################################################################################


# Tried running on login node but would have taken hrs so submitted as a slurm job 

cd ~/data/stickleback/Trimmed # move to directory with sequencing read folders

mkdir -p ~/data/stickleback/trimmed_fqs # make directory to put new files in (if it doesn't already exist)

for dir in */
do

indname=${dir##*-} # extract individual names
indname=${indname%/*} # remove trailing slash from indnames

cat $(find ./$dir -name "*_R1*" | sort) > ~/data/stickleback/trimmed_fqs/${indname}_R1.fastq.gz # find all R1 files and cat their contents to a new file write the contents of these files to another file
cat $(find ./$dir -name "*_R2*" | sort) > ~/data/stickleback/trimmed_fqs/${indname}_R2.fastq.gz # find all R2 files and cat their contents to a new file write the contents of these files to another file
cat $(find ./$dir -name "*_R0*" | sort) > ~/data/stickleback/trimmed_fqs/${indname}_R0.fastq.gz # find all R0 files and cat their contents to a new file write the contents of these files to another file

done


