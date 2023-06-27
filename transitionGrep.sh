if [ "$#" -ne 1 ]; then
    echo "Must specify grep string as parameter"
	exit
fi


echo
echo "Transitions matching '$1':"

grep -l "$1" transitions/* | while read x; 
do 
f=$(echo $x | sed 's/\s.*$//');

if [[ $f == transitions/*.txt ]];
then

if [ -e $f ]
then
  actorID=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
  targetID=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/[^_]*_//' );

  newActorID=$(cat $f | head -n 1 | sed 's/\s.*//' );
  newTargetID=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/\s.*//' );
  decayTime=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );


  reverseUseActor=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |  sed 's/[^ ]* //' |  sed 's/[^ ]* //' | sed 's/\s.*//' );

  reverseUseTarget=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |  sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );


  noUseActor=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |  sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |   sed 's/[^ ]* //' |  sed 's/[^ ]* //' |  sed 's/[^ ]* //' |sed 's/\s.*//' );

  noUseTarget=$(cat $f | head -n 1 | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |  sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |   sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' |sed 's/\s.*//' );


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


  reverseUseString="";
  
  if [[ $reverseUseActor == 1 ]];
  then
	  reverseUseString="$reverseUseString(Reverse Use Actor) "
  fi
  if [[ $reverseUseTarget == 1 ]];
  then
	  reverseUseString="$reverseUseString(Reverse Use Target) "
  fi


  noUseString="";
  
  if [[ $noUseActor == 1 ]];
  then
	  noUseString="$noUseString(No Use Actor) "
  fi
  if [[ $noUseTarget == 1 ]];
  then
	  noUseString="$noUseString(No Use Target) "
  fi

  echo "  $lastUseString$actor  +  $target   =   $newActor  +  $newTarget  $decayString  $reverseUseString $noUseString";

  newLineCount=$(wc -l < $f);
  if [[ $newLineCount -ge 1 ]]
  then
	  # comment present
	  echo -n "    ^[Comment: "
	  cat $f | tail -n 1
	  echo "]";
  fi
  echo ""
else 
  echo "$f removed"

  actorID=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
  targetID=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/[^_]*_//' );

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

  actor="";
  if [[ $actorID == -1 ]];
  then
	actor="[DECAY]"
  elif [[ $actorID == 0 ]];
  then
	actor="[HAND]"
  elif [[ $actorID == -2 ]];
  then
	actor="[DEFAULT]"
  else
	actorFile="objects/$actorID.txt"
    actor="(removed object)"
	if [ -e $actorFile ]
	then
		actor=$(cat $actorFile | sed -n 2p );
	fi
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
	targetFile="objects/$targetID.txt"
    target="(removed object)"
	if [ -e $targetFile ]
	then
		target=$(cat $targetFile | sed -n 2p );
	fi
	target="\"$target\"";
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

  echo "  $lastUseString$actor  +  $target"; 
  echo ""

fi
fi

done
