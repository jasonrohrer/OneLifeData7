for f in `ls -v objects/*`; do

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then

name=$(cat $f | sed -n 2p );

containable=$(cat $f | sed -n 3p );
containSize=$(cat $f | sed -n 4p );

cont=$(echo $containable | grep -o -E '[01]' | head -1 );
containableSize=$(echo $containSize | grep -o -E '[0-9]' | head -1 );


numSlots=0;
slotSize=0;

while read -r line
do


if [[ $line == numSlots* ]];
then

numSlots=$(echo $line | grep -o -E '[0-9]' | head -1 );
fi

if [[ $line == slotSize* ]];
then

slotSize=$(echo $line | grep -o -E '[0-9]' | head -1 );
fi
    
done < $f

if (( $(bc <<< "$numSlots > 0") ))
then
echo -n -e "$name\n  | $numSlots slots,  size = $slotSize" 

if (( $(bc <<< "$containable > 0") ))
then
echo -n -e "\n  | containableSize = $containableSize"
fi
echo ""

fi

fi

done
