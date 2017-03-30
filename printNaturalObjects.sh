
for f in objects/*; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

while read -r line
do


if [[ $line == mapChance* ]];
then

chance=$(echo $line | grep -o -E '[0-9.]+' | head -1 );
biomes=$(echo $line | grep -o -E 'biomes_[0-9,]+' | tail -1 );

if (( $(bc <<< "$chance > 0") ))
then
echo -e "$chance  $biomes \t $name" 
fi

break
fi

    
done < $f

fi

done
