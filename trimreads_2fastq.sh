#!/usr/bin/bash

for f in $(ls $trimmed_bam)
do
	X=$(basename $f .bam)
	readtools ReadsToFastq --input $f --output /Volumes/Temp1/haplotype_phasing/40females_F103/fastq_reads/"$X".fq.gz --interleavedInput true --barcodeInReadName true --outputFormat GZIP >> fasta.out 2>&1
done