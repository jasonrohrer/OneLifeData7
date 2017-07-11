echo "Pushing local changes to server..."

hg addremove -X sprites/cache.fcz -X objects/cache.fcz \
             -Xanimations/cache.fcz -X transitions/cache.fcz \
             -Xcategories/cache.fcz
             overlays sprites objects categories animations transitions ground music sounds

echo ""
echo "Full diff:"
hg diff --stat

echo ""
bash checkInReport.sh

echo ""



echo "Enter commit message."
echo -n "> "

read commitMessage

hg commit -m "$commitMessage"

echo "Pushing changes to server."

hg push


echo
echo -n "Press ENTER to close."

read userIn