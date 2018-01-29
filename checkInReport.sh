


echo
echo "Scene changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == scenes/*.txt ]] && ! [[ $f == scenes/next.txt ]];
then
if [ -e $f ]
then
  echo "  $f"; 
else
  echo "$f removed"
fi
fi

done




echo
echo "Sound changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == sounds/*.aiff ]];
then
if [ -e $f ]
then
  echo "  $f"; 
else
  echo "$f removed"
fi
fi

done


echo
echo "Raw Sound changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == soundsRaw/*.aiff ]];
then
if [ -e $f ]
then
  echo "  $f"; 
else
  echo "$f removed"
fi
fi

done


echo
echo "Music changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == music/*.ogg ]];
then
if [ -e $f ]
then
  echo "  $f"; 
else
  echo "$f removed"
fi
fi

done



echo
echo "Ground changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == ground/*.tga ]];
then
if [ -e $f ]
then
  echo "  $f"; 
else
  echo "$f removed"
fi
fi

done



echo
echo "Sprite changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == sprites/*.txt ]] && ! [[ $f == sprites/nextSpriteNumber.txt ]];
then
if [ -e $f ]
then
  name=$(cat $f | sed 's/\s.*$//');
  echo "  \"$name\""; 
else
  echo "$f removed"
fi
fi

done



echo
echo "Object changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == objects/*.txt ]] && ! [[ $f == objects/nextObjectNumber.txt ]];
then
if [ -e $f ]
then
  name=$(cat $f | sed -n 2p );
  echo "  \"$name\""; 
else
  echo "$f removed"
fi
fi

done




echo
echo "Animation changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == animations/*.txt ]];
then

if [ -e $f ]
then
  id=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
  anim=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/x.*//' | sed 's/.*_//' );

  oName=$(cat "objects/$id.txt" | sed -n 2p );

  echo "  \"$oName\"   $anim";
else 
  echo "$f removed"
fi
fi

done


echo
echo "Category changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == categories/*.txt ]];
then

if [ -e $f ]
then
  id=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' );
  
  oName=$(cat "objects/$id.txt" | sed -n 2p );

  echo "  \"$oName\" ";
else 
  echo "$f removed"
fi
fi

done



echo
echo "Transition changes:"

git diff --staged --stat | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == transitions/*.txt ]];
then

if [ -e $f ]
then
  actorID=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
  targetID=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/[^_]*_//' );

  newActorID=$(cat $f | sed 's/\s.*//' );
  newTargetID=$(cat $f | sed 's/[^ ]* //' | sed 's/\s.*//' );
  decayTime=$(cat $f | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );

  lastUseActor=0
  lastUseTarget=0

  if [[ $targetID == *"LA"* ]]; then
	  lastUseActor=1
  fi
  if [[ $targetID == *"LT"* ]]; then
	  lastUseTarget=1
  fi
  if [[ $targetID == *"L."* ]]; then
	  lastUseTarget=1
  fi


  if [[ $lastUseActor == 1 ]] || [[ $lastUseTarget == 1 ]];
  then
	  targetID=$(echo "$targetID" | sed 's/_.*//' );
  fi


  decayString=""
  actor="";
  if [[ $actorID == -1 ]];
  then
	actor="[DECAY]"
    decayString="($decayTime seconds)"
  elif [[ $actorID == 0 ]];
  then
	actor="[HAND]"
  elif [[ $actorID == -2 ]];
  then
	actor="[DEFAULT]"
  else
	actor=$(cat "objects/$actorID.txt" | sed -n 2p );
	actor="\"$actor\"";
  fi


  target="";
  if [[ $targetID == -1 ]] && [[ $newTargetID == 0 ]];
  then
	target="[USE/EAT]"
  elif [[ $targetID == -1 ]] && [[ $newTargetID != 0 ]];
  then
	target="[BARE-GROUND]"
  elif [[ $targetID == 0 ]];
  then
	target="[ON-PERSON]"
  else
	target=$(cat "objects/$targetID.txt" | sed -n 2p );
	target="\"$target\"";
  fi

  newActor=""
  if [[ $newActorID == 0 ]];
  then
	newActor="[NOTHING]"
  else
	newActor=$(cat "objects/$newActorID.txt" | sed -n 2p );
	newActor="\"$newActor\"";
  fi

  newTarget=""
  if [[ $newTargetID == 0 ]];
  then
	newTarget="[NOTHING]"
  else
	newTarget=$(cat "objects/$newTargetID.txt" | sed -n 2p );
	newTarget="\"$newTarget\"";
  fi

  lastUseString="";
  
  if [[ $lastUseActor == 1 ]];
  then
	  lastUseString="$lastUseString(Last Use Actor) "
  fi
  if [[ $lastUseTarget == 1 ]];
  then
	  lastUseString="$lastUseString(Last Use Target) "
  fi

  echo "  $lastUseString$actor  +  $target   =   $newActor  +  $newTarget  $decayString"; 
else 
  echo "$f removed"
fi
fi

done
