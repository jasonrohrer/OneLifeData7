
for f in transitions/*; do

	if [[ $f == transitions/*LT*.txt ]];
	then


		if [ -e $f ]
		then

			actorID=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
			targetID=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/[^_]*_//' );
			
			newActorID=$(cat $f | sed 's/\s.*//' );
			newTargetID=$(cat $f | sed 's/[^ ]* //' | sed 's/\s.*//' );
			decayTime=$(cat $f | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );

			reverseActor=$(cat $f | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );
			
			reverseTarget=$(cat $f | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );
			
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

			
			reverseString="";


			if [[ $reverseActor == 1 ]];
			then
				reverseString="$reverseString(reverse actor) "
			fi
			if [[ $reverseTarget == 1 ]];
			then
				reverseString="$reverseString(reverse target) "
			fi

			
			echo "  $lastUseString$actor  +  $target   =   $newActor  +  $newTarget  $decayString   $reverseString"; 
		fi
	fi
done
