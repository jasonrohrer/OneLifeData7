
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
	convert $f -alpha set -background none -channel A -evaluate multiply 0.0 +channel $f
done
