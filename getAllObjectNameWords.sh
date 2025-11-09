for file in objects/*.txt; do
  if [ -f "$file" ]; then
    head -n 2 "$file" | tail -n 1| sed "s/#.*//g" | sed "s/$.*//g" | sed "s/@.*//g" | sed "s/ /\n/g" | sed "s/-/\n/g"
  fi
done | grep -v "0" |  grep -v "," |  grep -v "\." |awk 'NF' | sed '/^.$/d' | tr '[:upper:]' '[:lower:]' | sort | uniq