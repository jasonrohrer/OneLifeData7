
for file in objects/*.txt; do
	if grep -q "numSlots=21" "$file"; then
		echo "Updating object file: $file"

		sed -i "s/numSlots=21/numSlots=24/" $file

		sed -i "s/slotPos=-61.000000,56.000000,vert=0,parent=-1/slotPos=-61.000000,56.000000,vert=0,parent=-1\nslotPos=-85.000000,36.000000,vert=0,parent=-1\nslotPos=-69.000000,36.000000,vert=0,parent=-1\nslotPos=-53.000000,36.000000,vert=0,parent=-1/" $file
	fi
done