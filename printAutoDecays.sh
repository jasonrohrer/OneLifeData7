
for f in transitions/*; do

	if [[ $f == transitions/*.txt ]];
	then


		if [ -e $f ]
		then
			actorID=$(echo "$f" | sed 's/.*\///' | sed 's/_.*//' );
			targetID=$(echo "$f" | sed 's/.*\///' | sed 's/\..*//' | sed 's/[^_]*_//' );

			newActorID=$(cat $f | sed 's/\s.*//' );
			newTargetID=$(cat $f | sed 's/[^ ]* //' | sed 's/\s.*//' );
			decayTime=$(cat $f | sed 's/[^ ]* //' | sed 's/[^ ]* //' | sed 's/\s.*//' );

			lastUse=0

			if [[ $targetID == *"L"* ]]; then
				lastUse=1
				
				targetID=$(echo "$targetID" | sed 's/_.*//' );
			fi

			decayString=""

			if [[ $actorID == -1 ]];
			then
				decayString="($decayTime seconds)"
				
				target=$(cat "objects/$targetID.txt" | sed -n 2p );
				target="\"$target\"";

				newTarget=""
				if [[ $newTargetID == 0 ]];
				then
					newTarget="[NOTHING]"
				else
					newTarget=$(cat "objects/$newTargetID.txt" | sed -n 2p );
					newTarget="\"$newTarget\"";
				fi
				
				echo "$target  =>  $newTarget  $decayString"; 			
			fi
		fi
	fi
done
