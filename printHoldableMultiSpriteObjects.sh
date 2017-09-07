
for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

while read -r line
do

isPerm=0

if [[ $line == permanent* ]];
then

perm=$(echo $line | grep -o -E '[01]' | head -1 );

if (( $(bc <<< "$perm == 1") ))
then
break 
fi

fi


if [[ $line == numSprites* ]];
then

numSprites=$(echo $line | grep -o -E '[0-9]+' | head -1 );

if (( $(bc <<< "$numSprites > 1") ))
then
echo -e "($numSprites) \t $name" 
fi

break 
fi



    
done < $f

fi

done
