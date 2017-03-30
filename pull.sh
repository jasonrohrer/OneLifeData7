echo "Pulling data from remote server..."

hg pull

hg update

rm */cache.fcz

echo
echo -n "Press ENTER to close."

read userIn