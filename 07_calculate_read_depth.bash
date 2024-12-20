#!/bin/bash
# Laura Dean
# 21/11/24
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --tasks-per-node=1
#SBATCH --mem=4g
#SBATCH --time=5:00:00
#SBATCH --array=1-535
#SBATCH --job-name=BD_readdepth
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/BD_read_depth/slurm-%x-%j.out


# load samtools
module load samtools-uoneasy/1.18-GCC-12.3.0

# set the config file for your array
config=/gpfs01/home/mbzlld/code_and_scripts/config_files/BigData_array_config.txt

# extract the individual name variable from your config file
individual=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# set variables
in_filepath=/gpfs01/home/mbzlld/data/stickleback/bams/raw_bams


# calculate depth for all bams
samtools depth \
-a \
-J \
-H \
$in_filepath/${individual}_raw.bam |
awk -F '\t' '(NR==1) {split($0,header);N=0.0;next;} {N++;for(i=3;i<=NF;i++) a[i]+=int($i);} END { for(x in a) print header[x], a[x]/N;}'

#-g UNMAP,SECONDARY,QCFAIL,DUP \

# unload samtools
module unload samtools-uoneasy/1.18-GCC-12.3.0






