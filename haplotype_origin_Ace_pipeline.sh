
##### Ace resistant mutations origin #####

###Author:Sonja_Lecic_07_2019

### Haplotype pipeline for Portugal, South Africa and Florida haplotypes ####


# clean bam files #
for f in $(ls $bam_files)
do
         X=$(basename $f .bam)
         picard CleanSam I=$f O=/Users/slecic/Documents/Portugal Ace freebayes/bam_files/"$X".clean
done


# sort #
for f in $(ls $bam_files)
do
        X=$(basename $f .clean)
        samtools sort $f -o /Users/slecic/Documents/Portugal Ace freebayes/bam_files/"$X".sort --threads 8
done


# remove duplicates #
for f in $(ls $bam_files)
do
         X=$(basename $f .bam)
         picard CleanSam I=$f O=/Users/slecic/Documents/Portugal Ace freebayes/bam_files/"$X".clean
done

# filter for quality > 20 #
for f in $(ls $bam_files)
do
        X=$(basename $f .remdup)
        samtools view -q 20 -f 0x0002 -F 0x0004 -F 0x0008 -b $f > /Users/slecic/Documents/Portugal Ace freebayes/bam_files/"$X".fq20
done


# extract 3R chromosome #
for f in $(ls $haplotype_origin_ace)
do
        X=$(basename $f .fq20)
        samtools view -b $f "3R" > /Volumes/LaCie/haplotype_origin_ace/"$X".3R
done


### add read group ##
picard AddOrReplaceReadGroups I=Dsim_Portugal_I022_aceRegion.bam O=Dsim_Portugal_I022_aceRegion_rg.bam RGID=22 RGLB=lib22 RGPL=illumina22 RGPU=unit22 RGSM=DsimPor22


## call SNPs on a population #
freebayes -f /Users/slecic/Documents/Portugal\ Ace\ freebayes/dsimM252.1.1.clean.wMel_wRi_Lactobacillus_Acetobacter.fa -F 0.02 -C 2 --pooled-continuous -m 20 -q 20 Dsim_Portugal_I001_aceRegion_rg.bam Dsim_Portugal_I002_aceRegion_rg.bam Dsim_Portugal_I003_aceRegion_rg.bam Dsim_Portugal_I005_aceRegion_rg.bam Dsim_Portugal_I006_aceRegion_rg.bam Dsim_Portugal_I007_aceRegion_rg.bam Dsim_Portugal_I008_aceRegion_rg.bam Dsim_Portugal_I017_aceRegion_rg.bam Dsim_Portugal_I021_aceRegion_rg.bam Dsim_Portugal_I026_aceRegion_rg.bam Dsim_Portugal_I034_aceRegion_rg.bam Dsim_Portugal_I038_aceRegion_rg.bam Dsim_Portugal_I039_aceRegion_rg.bam Dsim_Portugal_I043_aceRegion_rg.bam Dsim_Portugal_I044_aceRegion_rg.bam Dsim_Portugal_I045_aceRegion_rg.bam Dsim_Portugal_I047_aceRegion_rg.bam Dsim_Portugal_I051_aceRegion_rg.bam Dsim_Portugal_I059_aceRegion_rg.bam | vcffilter -f "QUAL > 20" > Portres3mut.vcf


## estimate nucleotide diversity with vcftools ##

vcftools --vcf Portres3mut.vcf --window-pi 7000 --out Portres3mutpi














