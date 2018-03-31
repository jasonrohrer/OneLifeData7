echo "Pushing local content changes to server..."


./checkInNoPush.sh


echo "Pushing changes to server."

git push


echo
echo -n "Press ENTER to close."

read userIn