# DNA Methylation Sequencing (Methyl-Seq) Analysis Pipeline

This repository contains a script for analyzing DNA methylation sequencing (Methyl-Seq) data using commonly used bioinformatics tools. The workflow includes quality control, alignment, methylation calling, and basic analysis.

## Overview

The analysis pipeline performs the following steps:
1. Quality control of raw sequencing reads using FastQC and MultiQC.
2. Preparation of the reference genome for Bismark.
3. Alignment of reads to the reference genome using Bismark with Bowtie2.
4. Deduplication of aligned reads.
5. Extraction of methylation calls using Bismark.
6. Generation of methylation summary reports.

## Requirements

### Software
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [MultiQC](https://multiqc.info/)
- [Bismark](https://www.bioinformatics.babraham.ac.uk/projects/bismark/)
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- [SAMtools](http://www.htslib.org/)

### Data
- Raw FASTQ files from Methyl-Seq experiments.
- Reference genome in FASTA format.

## Setup

1. Install the required software tools.
2. Ensure the raw FASTQ files and reference genome are prepared.

## Usage

1. Clone this repository or download the script.

```bash
git clone https://github.com/arbazattar11/methylseq
cd methylseq
```

2. Modify the variables in the script (`methylseq_analysis.sh`) to match your data and paths:
    - `SAMPLE_NAME`: Name of your sample.
    - `FASTQ_DIR`: Directory containing the raw FASTQ files.
    - `OUTPUT_DIR`: Directory where output files will be saved.
    - `REF_GENOME`: Path to the reference genome.
    - `BISMARK`: Path to the Bismark executable.
    - `BOWTIE2`: Path to the Bowtie2 executable.
    - `THREADS`: Number of threads to use for alignment.

3. Make the script executable:

```
chmod +x methylseq_analysis.sh
```

4. Run the script:

```
./methylseq_analysis.sh
```

## Script Details

### methylseq_analysis.sh

This bash script performs the following steps:

1. **FastQC**: Runs quality control checks on raw sequence data.
2. **MultiQC**: Aggregates FastQC reports into a single report.
3. **Bismark Genome Preparation**: Prepares the reference genome for alignment.
4. **Bismark Alignment**: Aligns raw reads to the reference genome using Bowtie2.
5. **Bismark Deduplication**: Removes duplicate reads from the alignment.
6. **Bismark Methylation Extraction**: Extracts methylation calls from the deduplicated BAM file and generates bedGraph and CX reports.
7. **Bismark Reports**: Generates a summary report of the methylation extraction process.
8. **SAMtools Indexing**: Indexes the deduplicated BAM files for further analysis.

## Output

The script generates several output files and directories:
- `fastqc/`: Directory containing FastQC reports.
- `multiqc_report.html`: Aggregated report from MultiQC.
- `alignment/`: Directory containing alignment files (SAM, BAM, and index files).
- `methylation/`: Directory containing methylation call files (bedGraph, CX, and reports).

## Troubleshooting

If you encounter any issues, ensure that:
- All paths and filenames are correct.
- All required software tools are installed and accessible.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Babraham Bioinformatics](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) for FastQC and Bismark.
- [MultiQC](https://multiqc.info/) for aggregating QC reports.
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) for read alignment.
- [HTSlib](http://www.htslib.org/) for SAMtools.

## Contact

For any questions or issues, please contact [Arbaz] at [arbazattar1137@gmail.com].
