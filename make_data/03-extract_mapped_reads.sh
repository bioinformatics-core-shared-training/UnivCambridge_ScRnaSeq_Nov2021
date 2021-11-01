#!/bin/bash
#SBATCH -A LEYSER-SL2-CPU
#SBATCH -D /rds/user/hm533/hpc-work/scRNA-seq_course/make_data
#SBATCH -J public_data
#SBATCH -o logs/03-extract_mapped_reads_%a.log
#SBATCH -c 12
#SBATCH -t 03:00:00
#SBATCH -p icelake
#SBATCH --mem-per-cpu=3380
#SBATCH -a 2-3 # rows in the CSV file with SRA information

source activate rnaseq

# get sample information from the table
INFO=$(head -n "$SLURM_ARRAY_TASK_ID" sample_info.csv | tail -n 1)

# split relevant parts
ID=$(echo $INFO | cut -d "," -f 1)
SAMPLE=$(echo $INFO | cut -d "," -f 2)
TYPE=$(echo $INFO | cut -d "," -f 3)

# extract aligned read names (note that only R2 is aligned to genome)
samtools view -F 4 -h -@ $(($SLURM_CPUS_PER_TASK - 1)) results/cellranger/${SAMPLE}/outs/possorted_genome_bam.bam 21 22 |\
  samtools sort -@ $(($SLURM_CPUS_PER_TASK - 1)) -u |\
  samtools fastq -@ $(($SLURM_CPUS_PER_TASK - 1)) |\
  sed -n '1~4p' | sed 's/^@//' > results/${SAMPLE}_aligned_read_names.txt

# extract reads from original files
mkdir -p ../CourseMaterials/Data/reads

seqtk subseq data/reads/${SAMPLE}/${ID}_S1_L001_R1_001.fastq.gz results/${SAMPLE}_aligned_read_names.txt |\
  seqtk sample -s1 - 1000000 |\
  gzip > ../CourseMaterials/Data/reads/${ID}_S1_L001_R1_001.fastq.gz
seqtk subseq data/reads/${SAMPLE}/${ID}_S1_L001_R2_001.fastq.gz results/${SAMPLE}_aligned_read_names.txt |\
  seqtk sample -s1 - 1000000 |\
  gzip > ../CourseMaterials/Data/reads/${ID}_S1_L001_R2_001.fastq.gz
seqtk subseq data/reads/${SAMPLE}/${ID}_S1_L001_I1_001.fastq.gz results/${SAMPLE}_aligned_read_names.txt |\
  seqtk sample -s1 - 1000000 |\
  gzip > ../CourseMaterials/Data/reads/${ID}_S1_L001_I1_001.fastq.gz
