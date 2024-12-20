#!/bin/bash
# Laura Dean
# 22/11/24
# for running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=19
#SBATCH --tasks-per-node=19
#SBATCH --array=1-535
#SBATCH --mem=35g
#SBATCH --time=36:00:00
#SBATCH --job-name=BD_clean
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

########################################################
# SET UP YOUR ENVIRONMENT AND SPECIFY DATA INFORMATION #
########################################################

# specify your config file
config=/gpfs01/home/mbzlld/code_and_scripts/config_files/BigData_array_config.txt

# extract the sample name for the current slurm task ID
individual=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# set the input data location
master_filepath=/gpfs01/home/mbzlld/data/stickleback

echo "This is array task ${SLURM_ARRAY_TASK_ID}, cleaning individual $individual,
cleaned output BAM files will be written to the folder $master_filepath/bams/cleaned_bams"

# load the necessary modules
module load samtools-uoneasy/1.18-GCC-12.3.0
module load bcftools-uoneasy/1.18-GCC-13.2.0




# make the output directory if it doesn't already exist
mkdir -p $master_filepath/bams/clean_bams

# Remove unmapped reads and do quality filtering
# -q mapping quality greater than or equal to 40
# -f include reads mapped in a propper pair
# -F Only include reads which are not read unmapped or mate unmapped
samtools view \
--threads 19 \
-q 40 \
-f 2 \
-F 4 \
-b $master_filepath/bams/raw_bams/${individual}_raw.bam |
# Mark duplicate reads
samtools markdup -r --threads 19 - $master_filepath/bams/clean_bams/$individual.bam
# adding the  -r flag to the command above will remove the duplicate reads

# index the final BAM files
samtools index -@ 19 $master_filepath/bams/clean_bams/$individual.bam

# check the mapping
echo "after cleaning and filtering the final mapping success was:"
samtools flagstat $master_filepath/bams/clean_bams/$individual.bam






