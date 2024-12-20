#!/bin/bash
# Laura Dean
# 18/11/24
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=60g
#SBATCH --time=168:00:00
#SBATCH --job-name=Trimmed_download
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out


# Had to re-do the rclone config because it had been too long since I used it
# instructions for this are in the Bioinftech dir on my onedrive

# load the Rclone module
module load rclone-uon/1.65.2

# drive options for rclone
#OrgOne MacCollLab1 MacCollLab2 Laura

# Copy the fastq files from sharepoint to Ada
rclone --transfers 1 --checkers 1 --bwlimit 100M --checksum copy MacCollLab2:HPC_data_backup/bigdata/Trimmed /gpfs01/home/mbzlld/data/stickleback/Trimmed1
 

# and check that the two folders are identical
rclone check --one-way MacCollLab2:HPC_data_backup/bigdata/Trimmed /gpfs01/home/mbzlld/data/stickleback/Trimmed1

# unload the rclone module
module unload rclone-uon/1.65.2

