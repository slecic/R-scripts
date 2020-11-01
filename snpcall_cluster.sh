#!/bin/bash

# yarn queue name
queue=pg4
# identify the job
job=sonja_freebayes_test
# number of mappers
nrmaps=70
# memory per mapper
#mapmem=10g
# let mapmem=1024*1024*10

# hdfs paths
idir=/user/vetgrid11/Sonja/freebayes_input
odir=/user/vetgrid11/Sonja/freebayes_output2
ldir=/user/vetgrid11/Sonja/freebayes_log
vdir=/user/vetgrid11/Sonja/freebayes_vcf

PATH=$PATH:$HADOOP_PREFIX/bin
streaming_jar=$HADOOP_PREFIX/share/hadoop/tools/lib/hadoop-streaming-2.7.5.jar

hadoop fs -rm -r -f $odir

# write mapper script
mapper_script=$(mktemp freebayes.XXXXX)
cat > $mapper_script <<-'TOK'
	#!/bin/bash
	export PATH=$HADOOP_HOME/bin:$PATH
	while read FN; do
	   echo "reporter:status:downloading bam ..." >&2
	   hadoop fs -get /user/vetgrid11/Sonja/freebayes_input/$FN in.bam
	   cmd="freebayes/bin/freebayes -f ref.fa -b in.bam -C 2 --pooled-continuous -X -F 0.01"
	   echo "reporter:status:running freebayes ..." >&2
	   eval "$cmd"
 	   echo "reporter:status:finished with $FN" >&2
	done
	echo "reporter:status:exiting ..." >&2
	TOK
chmod +x $mapper_script

# start streaming job
hadoop jar $streaming_jar \
    -D mapreduce.job.name=$job \
    -D mapreduce.job.maps=$nrmaps \
    -D mapreduce.job.queuename=$queue \
    -files hdfs://$idir/dsimM252.1.1.clean.wMel_wRi_Lactobacillus_Acetobacter.fa#ref.fa,file://$(pwd)/${mapper_script}#mapper.sh \
    -archives hdfs:///libexec/linux/freebayes/1.2.0/freebayes.tar.gz#freebayes \
    -input $idir/input.txt -output $odir/ -mapper ./mapper.sh  -reducer NONE  
#    -D mapreduce.map.memory.mb=$mapmem \

#rm -f $mapper_script
