#!/bin/bash
#SBATCH -A LEYSER-SL2-CPU
#SBATCH -D /rds/user/hm533/hpc-work/scRNA-seq_course/make_data
#SBATCH -J public_data
#SBATCH -o logs/00-download_SRA_%a.log
#SBATCH -c 1
#SBATCH -t 12:00:00
#SBATCH -p cclake,cclake-himem
#SBATCH -a 2-3 # rows in the CSV file with SRA information

# activate conda environment
source activate sra

# get sample information from the table
INFO=$(head -n "$SLURM_ARRAY_TASK_ID" sample_info.csv | tail -n 1)

# split relevant parts
ID=$(echo $INFO | cut -d "," -f 1)
SAMPLE=$(echo $INFO | cut -d "," -f 2)
TYPE=$(echo $INFO | cut -d "," -f 3)
LINK=$(echo $INFO | cut -d "," -f 5)

# move to data folder
mkdir -p data/reads/
cd data/reads/

# create directory structure
OUTDIR="${SAMPLE}/"
mkdir -p "$OUTDIR"
cd "$OUTDIR"

# download file
wget -O "${ID}.sra" "$LINK"

# convert to fastq
fastq-dump -O . --gzip --split-files "${ID}.sra"

# rename files for cellranger
# 1 = I1
# 2 = R1
# 3 = R2
mv "${ID}_1.fastq.gz" "${ID}_S1_L001_I1_001.fast.gz"
mv "${ID}_2.fastq.gz" "${ID}_S1_L001_R1_001.fast.gz"
mv "${ID}_3.fastq.gz" "${ID}_S1_L001_R2_001.fast.gz"

# remove original file
rm "${ID}.sra"