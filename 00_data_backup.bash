#!/bin/bash
# Laura Dean
# 13/1/25
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40g
#SBATCH --time=168:00:00
#SBATCH --job-name=StickleBackup
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

# possible sharepoint sites
# MacCollLab1
# MacCollLab2
# OrgOne

# load the Rclone module
module load rclone-uon/1.65.2

# Copy all of the files from your folder on Augusta to a folder on sharepoint
rclone --transfers 1 --checkers 1 --bwlimit 100M --checksum copy ~/data/stickleback MacCollLab2:Laura/stickleback

# and check that the two folders are identical
rclone check --one-way ~/data/stickleback MacCollLab2:Laura/stickleback

# unload the rclone module
module unload rclone-uon/1.65.2

