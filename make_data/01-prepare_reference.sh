#!/bin/bash
#SBATCH -A LEYSER-SL2-CPU
#SBATCH -D /rds/user/hm533/hpc-work/scRNA-seq_course/make_data
#SBATCH -J mkref
#SBATCH -o logs/01-prepare_reference.log
#SBATCH -c 8
#SBATCH -t 12:00:00
#SBATCH -p cclake
#SBATCH --mem-per-cpu=3420MB

mkdir -p data/reference/
cd data/reference/


#### Download reference genome ####

# download two chromosomes only (to reduce size of the data)
wget --no-check-certificate -O chr21.fa.gz https://ftp.ensembl.org/pub/release-104/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.21.fa.gz
wget --no-check-certificate -O chr22.fa.gz https://ftp.ensembl.org/pub/release-104/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.22.fa.gz

# concatenate
cat chr21.fa.gz chr22.fa.gz > genome.fa.gz 
rm chr21.fa.gz chr22.fa.gz 

# unzip
gunzip genome.fa.gz


#### Download and prepare gene annotation ####

# download from ENSEMBL
wget --no-check-certificate -O annotation.gtf.gz https://ftp.ensembl.org/pub/release-104/gtf/homo_sapiens/Homo_sapiens.GRCh38.104.chr.gtf.gz

# decompress (for cellranger)
gunzip annotation.gtf.gz

grep -E "^21|^#" reference/Homo_sapiens.GRCh38.104.chr.gtf > ../CourseMaterials/Data/reference/Homo_sapiens.GRCh38.104.chr21.gtf

#### cellranger indexing ####

cellranger mkref \
  --nthreads="${SLURM_CPUS_PER_TASK}" \
  --genome=cellranger_index \
  --fasta=genome.fa \
  --genes=annotation.gtf
