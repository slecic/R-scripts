#!/usr/bin/bash

for f in $(ls $bam_files)
do
        X=$(basename $f .remdup)
        samtools view -q 20 -f 0x0002 -F 0x0004 -F 0x0008 -b $f > /Volumes/LaCie/haplotype_origin_ace/"$X".fq20
done
