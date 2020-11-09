#!bin/bash

for f in $(ls $fq20)
do
        X=$(basename $f .rg)
        picard AddOrReplaceReadGroups I="$X" O="$X".rg RGID="$X" RGLB="$X" RGPL="$X" RGPU="$X" RGSM="$X"
done
