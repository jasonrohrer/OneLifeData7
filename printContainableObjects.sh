for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );
containSize=$(cat $f | sed -n 4p );

while read -r line
do


if [[ $line == containable* ]];
then

cont=$(echo $line | grep -o -E '[01]' | head -1 );
size=$(echo $containSize | grep -o -E '[0-9]' | head -1 );

if (( $(bc <<< "$cont == 1") ))
then
echo -e "$name\n  | size = $size" 
fi

break
fi

    
done < $f

fi

done
