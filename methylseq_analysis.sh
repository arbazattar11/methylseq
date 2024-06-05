#!/bin/bash

# Variables
SAMPLE_NAME="sample_name"
FASTQ_DIR="/path/to/fastq"
OUTPUT_DIR="/path/to/output"
REF_GENOME="/path/to/reference/genome.fasta"
BISMARK="/path/to/bismark"
BOWTIE2="/path/to/bowtie2"
THREADS=8

# Create necessary directories
mkdir -p ${OUTPUT_DIR}/fastqc
mkdir -p ${OUTPUT_DIR}/alignment
mkdir -p ${OUTPUT_DIR}/methylation

# Step 1: Run FastQC for quality control of raw reads
fastqc ${FASTQ_DIR}/*.fastq.gz -o ${OUTPUT_DIR}/fastqc

# Step 2: Aggregate FastQC reports using MultiQC
multiqc ${OUTPUT_DIR}/fastqc -o ${OUTPUT_DIR}/fastqc

# Step 3: Prepare the reference genome for Bismark
${BISMARK}/bismark_genome_preparation --bowtie2 --path_to_aligner ${BOWTIE2} ${REF_GENOME}

# Step 4: Align reads to the reference genome using Bismark with Bowtie2
${BISMARK}/bismark --genome ${REF_GENOME} -1 ${FASTQ_DIR}/*_R1_*.fastq.gz -2 ${FASTQ_DIR}/*_R2_*.fastq.gz -o ${OUTPUT_DIR}/alignment -p ${THREADS}

# Step 5: Deduplicate aligned reads using Bismark
${BISMARK}/deduplicate_bismark --bam ${OUTPUT_DIR}/alignment/${SAMPLE_NAME}_R1_*.bismark_bt2_pe.bam

# Step 6: Extract methylation calls using Bismark
${BISMARK}/bismark_methylation_extractor --bedGraph --CX --genome_folder ${REF_GENOME} ${OUTPUT_DIR}/alignment/${SAMPLE_NAME}_R1_*.deduplicated.bam -o ${OUTPUT_DIR}/methylation

# Step 7: Generate a summary report of the methylation extraction
${BISMARK}/bismark2report
${BISMARK}/bismark2summary

# Step 8: Index the BAM files using SAMtools
samtools index ${OUTPUT_DIR}/alignment/${SAMPLE_NAME}_R1_*.deduplicated.bam

# Summary
echo "Methyl-Seq analysis pipeline completed successfully."
