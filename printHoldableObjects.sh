
for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

while read -r line
do


if [[ $line == permanent* ]];
then

perm=$(echo $line | grep -o -E '[01]' | head -1 );

if (( $(bc <<< "$perm == 0") ))
then
echo -e "$name" 
fi

break
fi

    
done < $f

fi

done
