#!/usr/bin/bash

for f in $(ls $haplotype_origin_ace)
do
        X=$(basename $f .clean)
        samtools sort --threads 8 -o /Volumes/LaCie/haplotype_origin_ace/"$X"_sort.bam $f
done
