
# copy all the depth statistics to a single file
cat /gpfs01/home/mbzlld/code_and_scripts/slurm_out_scripts/BD_read_depth/slurm-BD_readdepth-* > ~/data/stickleback/stickleback_raw_bam_coverage_depth.txt

# and get rid of the file extension and path leaving just the individual name and the mean depth
sed -i 's/\.bam//' ~/data/stickleback/stickleback_raw_bam_coverage_depth.txt
sed -i 's@.*/@@' ~/data/stickleback/stickleback_raw_bam_coverage_depth.txt
sed -i 's/_raw//' ~/data/stickleback/stickleback_raw_bam_coverage_depth.txt


