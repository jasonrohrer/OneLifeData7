for f in `ls -v objects/*`; do

	if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
	then
		
		name=$(cat $f | sed -n 2p );
		
		blocking=$(cat $f | sed -n 7p );
		
		block=$(echo $blocking | grep -o -E '[01]' | head -1 );
		
		if (( $(bc <<< "$block > 0") ))
		then
			echo -n -e "$name\n" 	
		fi
	fi
	
done
