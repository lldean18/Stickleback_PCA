#!/bin/bash
# Laura Dean
# 20/12/24
# For running on the UoN HPC Ada

#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=60g
#SBATCH --time=168:00:00
#SBATCH --job-name=Stickle_call
#SBATCH --array=1-23
#SBATCH --output=/gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/slurm-%x-%j.out

########################################################
# SET UP YOUR ENVIRONMENT AND SPECIFY DATA INFORMATION #
########################################################

# specify your array config file that lists the chromosome numbers
config=/gpfs01/home/mbzlld/code_and_scripts/config_files/stickleback_chr_callSNPs_config.txt

# extract the chromosome name from the array config file
chr=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)

# set variables
master_filepath=/gpfs01/home/mbzlld/data/stickleback # set the master data location
reference_genome=/gpfs01/home/mbzlld/data/reference_genomes/G_aculeatus/version5-UGA/stickleback_v5_assembly.fa
VCF=stickleback_${chr}.vcf.gz # set the name of the output vcf file
regionsdir=/gpfs01/home/mbzlld/code_and_scripts/Regions_files/G_aculeatus

# export the paths and load required environment modules
module load bcftools-uoneasy/1.18-GCC-13.2.0

# print to the file the array that is being worked on...
echo "This is array task ${SLURM_ARRAY_TASK_ID}, calling SNPs for chromosome ${chr},
and writing them to the file ${VCF}"

############################
# SNP and genotype calling #
############################

# create a list of all of the BAM files that we will call into the same variant file
if [ ! -f $master_filepath/bams/BamFileList.txt ]; then
	ls $master_filepath/bams/clean_bams/*.bam > $master_filepath/bams/BamFileList.txt
fi

# create a vcfs directory to save the VCF file to if it doesnt already exist
mkdir -p $master_filepath/vcfs

# Generate genotype likelihoods for the BAM files using mpileup
# then pipe this to call to generate a BCF file of genetic variants
bcftools mpileup \
--threads 16 \
--output-type u \
--max-depth 10000 \
--min-MQ 20 \
--min-BQ 30 \
--platforms ILLUMINA \
--annotate FORMAT/DP,FORMAT/AD \
--regions-file $regionsdir/Chromosome_${SLURM_ARRAY_TASK_ID}.txt \
--fasta-ref $reference_genome \
--bam-list $master_filepath/bams/BamFileList.txt |
# -m = use the multiallelic caller
# -v = output variant sites only
# -P = mutation rate (set at default)
bcftools call \
--threads 16 \
-m \
-v \
-P 1e-6 \
-a GQ \
-O z \
-o $master_filepath/vcfs/$VCF

#unzip the vcf file
#gzip -d $master_filepath/vcfs/$VCF

echo "The SNPs have now been called, proced to sorting and indexing"

# Sort and Index the VCF file
bcftools sort -Oz -o $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz $master_filepath/vcfs/$VCF
rm $master_filepath/vcfs/$VCF
bcftools index $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz

# make an unzipped copy of the vcf file
#gunzip < $master_filepath/vcfs/$analysis_name.vcf.gz > $master_filepath/vcfs/$analysis_name.vcf

# Output some check information on the VCF file you have generated:
# list the sameples contained in the VCF file
echo "These are the individuals in the VCF file:"
bcftools query -l $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz 
# Count all variants in the file
echo "This is the number of variants in the file:"
bcftools view -H $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz | wc -l
# Count all SNPs in the file
echo "This is the number of SNPs in the file:"
bcftools view -H -v snps $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz | wc -l
# Count all indels in the file
echo "This is the number of indels in the file:"
bcftools view -H -v indels $master_filepath/vcfs/${VCF%.*.*}_sorted.vcf.gz | wc -l

# unload the modules you have used
module unload bcftools-uoneasy/1.18-GCC-13.2.0

