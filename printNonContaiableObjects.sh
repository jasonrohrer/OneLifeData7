for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );
containSize=$(cat $f | sed -n 4p );
permanent=$(cat $f | sed -n 5p );

while read -r line
do


if [[ $line == containable* ]];
then

cont=$(echo $line | grep -o -E '[01]' | head -1 );
size=$(echo $containSize | grep -o -E '[0-9]' | head -1 );
perm=$(echo $permanent | grep -o -E '[01]' | head -1 );

if (( $(bc <<< "$cont == 0") )) && (( $(bc <<< "$perm == 0") )) && ! [[ $name == *Female* ]]  && ! [[ $name == *Male* ]] && ! [[ $name == *@* ]]
then
echo -e "$name\n" 
fi

break
fi

    
done < $f

fi

done
