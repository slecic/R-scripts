#!/bin/bash

### triple mapping on the cluster
## Author:Sonja_Lecic

PREF=(pool_415_repl5_F0_1_trim pool_415_repl8_F0_1_trim pool_415_repl5_F0_2_trim pool_415_repl5_F0_3_trim);

for pref in ${PREF[@]}; do
  (
    cmd="${path_distmap}distmap --mapper bwa --mapper bowtie2 --mapper novoalign --mapper-path ${path_distmap}executables/bwa-0.7.13/bwa --mapper-path ${path_distmap}executables/bowtie2-2.2.6/bowtie2 --mapper-path ${path_distmap}executables/novocraft/novoalign --mapper-args \"bwamem\" --mapper-args \"-q --end-to-end -X 1500\" --mapper-args \"-i 250,100 -F STDFQ -o SAM -r RANDOM\" --reference-fasta /Volumes/cluster/Reference/dsimM252.1.1.clean.wMel_wRi_Lactobacillus_Acetobacter.fa --input \"${pref}_1.fq.gz,${pref}_2.fq.gz\" --no-trim --picard-mergesamfiles-jar ${path_distmap}executables/MergeSamFiles.jar --picard-sortsam-jar ${path_distmap}executables/SortSam.jar --queue-name pg1 --job-desc \"${pref}_bwamem_bowtie2_novoalign_mapping_myname\" --output-format bam --output ${pref}_bwamem_bowtie2_novoalign_mapping_myname";
    echo "$cmd";
    eval $cmd 2> ${pref}_myname_log;
  )&
done
