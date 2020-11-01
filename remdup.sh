#!/usr/bin/bash

for f in $(ls $bam_files)
do
        X=$(basename $f .clean)
        picard MarkDuplicates REMOVE_DUPLICATES=true I=$f O=/Volumes/LaCie/haplotype_origin_ace/"$X".remdup M=pe.pimetrics.txt VALIDATION_STRINGENCY=SILENT
done
