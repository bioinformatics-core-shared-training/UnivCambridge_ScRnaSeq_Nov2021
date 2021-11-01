#!/bin/bash
#SBATCH -A LEYSER-SL2-CPU
#SBATCH -D /rds/user/hm533/hpc-work/scRNA-seq_course/make_data
#SBATCH -J public_data
#SBATCH -o logs/02-cellranger_%a.log
#SBATCH -c 48
#SBATCH -t 36:00:00
#SBATCH -p icelake
#SBATCH --mem-per-cpu=3380
#SBATCH -a 2-3 # rows in the CSV file with SRA information

echo "Start: $(date)"

# get sample information from the table
INFO=$(head -n "$SLURM_ARRAY_TASK_ID" sample_info.csv | tail -n 1)

# split relevant parts
SAMPLE=$(echo $INFO | cut -d "," -f 2)
TYPE=$(echo $INFO | cut -d "," -f 3)

# reference genome
REF="data/reference/cellranger_index"

# run cellranger count pipeline
cellranger count \
  --id="${SAMPLE}" \
  --transcriptome="${REF}" \
  --fastqs="data/reads/${SAMPLE}/" \
  --localcores="${SLURM_CPUS_PER_TASK}" \
  --mempercore="${SLURM_MEM_PER_CPU}"

# move to output directory
mkdir -p results/cellranger/
mv "${SAMPLE}" results/cellranger/

echo "End: $(date)"
