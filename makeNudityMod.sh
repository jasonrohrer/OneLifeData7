
mkdir nudityMod
mkdir nudityMod/sprites
cp NudityModInstructions.html nudityMod

cp sprites/592.tga nudityMod/sprites/
cp sprites/593.tga nudityMod/sprites/
cp sprites/594.tga nudityMod/sprites/
cp sprites/595.tga nudityMod/sprites/
cp sprites/596.tga nudityMod/sprites/
cp sprites/597.tga nudityMod/sprites/
cp sprites/598.tga nudityMod/sprites/
cp sprites/599.tga nudityMod/sprites/
cp sprites/600.tga nudityMod/sprites/


cd nudityMod/sprites/

for f in *.tga; do
	convert $f -alpha set -background none -channel A -evaluate set 0% -channel R -evaluate set 100% -channel G -evaluate set 100% -channel B -evaluate set 100%  $f
done
