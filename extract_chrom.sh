#!/usr/bin/bash

for f in $(ls $haplotype_origin_ace)
do
        X=$(basename $f .fq20)
        samtools view -b $f "3R" > /Volumes/LaCie/haplotype_origin_ace/"$X".3R
done
