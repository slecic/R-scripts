#!/usr/bin/bash

for f in $(ls $haplotype_origin_ace)
do
         X=$(basename $f .clean)
         picard CleanSam I=$f O=/Volumes/LaCie/haplotype_origin_ace/"$X".clean
done
