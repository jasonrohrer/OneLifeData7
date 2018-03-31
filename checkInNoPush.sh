echo "Committing local content changes..."

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

echo "Commit done."
