#!/bin/bash
#SBATCH -A korbel                   # group to which you belong
#SBATCH -p 1month                   # partition (queue)
#SBATCH -N 1                        # number of nodes
#SBATCH -n 4                        # number of cores
#SBATCH --no-requeue                # never requeue this job
#SBATCH -J atac                     # job name
#SBATCH --mem 38000M                # memory pool for all cores
#SBATCH -t 96:00:00                 # time
#SBATCH -o atac.%N.%j.out           # STDOUT
#SBATCH -e atac.%N.%j.err           # STDERR
#SBATCH --mail-type=FAIL            # notifications for job done & fail
#SBATCH --mail-user=rausch@embl.de  # send-to address
#SBATCH --tmp=50G
#SBATCH --hint=compute_bound

# Do we have EasyBuild and module
module -v > /dev/null 2>&1 || { echo >&2 "EasyBuild modules are required. Aborting."; exit 1; }

# Load required modules
module load Java
module load SAMtools
module load BCFtools
module load Bowtie2
module load BEDTools
module load MACS2
module load HTSlib
module load vt
module load Ghostscript
module load R-bundle-Bioconductor
module load alfred
module load Perl
module load cutadapt

# Fetch ATAC-Seq script
ATACSCRIPT=${1}
shift

# Run analysis pipeline
ls ${ATACSCRIPT}
${ATACSCRIPT} $@
