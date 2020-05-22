for FILE in *; do grep -q Track $FILE && grep -q Cart $FILE && grep -q "numSlots=4" $FILE && echo $FILE; done > ../cartList.txt


while read p; do
	echo "$p"
	
	sed -i "s/numSlots=4/numSlots=8/" $p
	
	sed -i "s/numSprites=/slotPos=-18.000000,48.000000,vert=1,parent=-1\nslotPos=-6.000000,48.000000,vert=1,parent=-1\nslotPos=8.000000,48.000000,vert=1,parent=-1\nslotPos=17.000000,48.000000,vert=1,parent=\nnumSprites=/" $p

done <../cartList.txt

rm ../cartList.txt