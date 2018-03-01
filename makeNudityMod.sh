
mkdir nudityMod

cp sprites/592.tga nudityMod
cp sprites/593.tga nudityMod
cp sprites/594.tga nudityMod
cp sprites/595.tga nudityMod
cp sprites/596.tga nudityMod
cp sprites/597.tga nudityMod
cp sprites/598.tga nudityMod
cp sprites/599.tga nudityMod
cp sprites/600.tga nudityMod


cd nudityMod

for f in *.tga; do
	#convert $f -alpha set -background none -channel A -evaluate multiply 0.50 +channel -channel R -evaluate set 1 +channel -channel G -evaluate set 255 -channel B -evaluate set 255  $f

	convert $f -alpha set -background none -channel A -evaluate set 0% -channel R -evaluate set 100% -channel G -evaluate set 100% -channel B -evaluate set 100%  $f
done
