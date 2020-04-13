for f in `ls -v objects/*`; do

	if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
	then
		
		name=""
		food=0
		
		# MUCH faster to do this all in bash instead of calling external
		# programs like grep and sed
		
		i=0
		while read -r line
		do
			if [[ "$i" -eq 1 ]]; then
				name=$line
			elif [[ "$line" == "foodValue="* ]]; then
				food=${line:10}
				break
			fi
			i=$((i+1))
		done < "$f"

		if [[ "$food" -ne 0 ]]; then
			echo -n -e "$food:\t$name\n"
		fi
	fi
	
done
