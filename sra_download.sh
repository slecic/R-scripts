#!/usr/bin/bash

for file in $(<SRR_Acc_List-6.txt)
do

     date
     prefetch SRR23${file} && vdb-validate SRR23${file} && fastq-dump --split-files SRR23${file} --gzip -O Fastq_florida
     date
done
