
for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

while read -r line
do


if [[ $line == deadlyDistance* ]];
then

dist=$(echo $line | grep -o -E '[0-9.]+' | head -1 );

if (( $(bc <<< "$dist > 0") ))
then
echo -e "$dist\t $name" 
fi

break
fi

    
done < $f

fi

done
