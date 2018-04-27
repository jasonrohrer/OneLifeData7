for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

while read -r line
do


if [[ $line == numUses* ]];
then

uses=$(echo $line | grep -o -E '[0-9]+' | head -1 );
useChance=$(echo $line | sed 's/.*,//' | head -1 );


if [[ $useChance == numUses* ]];
then
	useChance="1.0"
fi


if (( $(bc <<< "$uses > 1") ))
then
echo -e "$name\n  | uses = $uses   [$useChance]" 
fi

break
fi

    
done < $f

fi

done
