#! /bin/bash

####
for i in *.sync; do
	pref=${i%.sync}
	echo $pref
	echo "equal coverage" $pref
	perl /Volumes/Temp/Softwares/popoolation2_1201/sample-synchronized.pl --target-coverage 100 --min-coverage 10  --max-coverage  350  --input $i  --output "all_novo"$pref"_cov100_min10"$j".sync" 
done

