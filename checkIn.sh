echo "Pushing local content changes to server..."

git add -A overlays sprites objects categories animations transitions ground music sounds soundsRaw scenes

echo ""
echo "Full diff:"
git --no-pager diff --staged --stat overlays sprites objects categories animations transitions ground music sounds soundsRaw scenes

echo ""
bash checkInReport.sh

echo ""



echo "Enter commit message."
echo -n "> "

read commitMessage

git commit -m "$commitMessage"

echo "Pushing changes to server."

git push


echo
echo -n "Press ENTER to close."

read userIn