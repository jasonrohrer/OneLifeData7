# script for renaming object files, and replacing their references
# in transitions

# replace "-n" with "" to execute (-n makes dry run for rename)
flag="-n"

rename $flag 's/7120/3961/' $(find objects transitions -name "*7120*")
echo
rename $flag 's/7121/3962/' $(find objects transitions -name "*7121*")
echo
rename $flag 's/7122/3963/' $(find objects transitions -name "*7122*")
echo
rename $flag 's/7123/3964/' $(find objects transitions -name "*7123*")
echo
rename $flag 's/7124/3965/' $(find objects transitions -name "*7124*")


sed -i "s/7120/3961/" objects/*.txt transitions/*.txt
sed -i "s/7121/3962/" objects/*.txt transitions/*.txt
sed -i "s/7122/3963/" objects/*.txt transitions/*.txt
sed -i "s/7123/3964/" objects/*.txt transitions/*.txt
sed -i "s/7124/3965/" objects/*.txt transitions/*.txt
