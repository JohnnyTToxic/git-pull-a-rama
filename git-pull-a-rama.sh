#!/bin/bash

gitloc=$(which git)

if [[ $1 == "blind" ]]; then
	for i in $(find "$HOME" -type d -name '.git'); do
		dir=$(dirname "$i")
	        idgit=$(basename "$dir")
		printf "Checking %s: " "$idgit"
		cd "$dir" && "$gitloc" pull
	done
	exit 0
fi

printf "\\nSearching for .git repos located in %s\\n" "$HOME"
printf "%.0s=" {1..70}
printf "\\n"
for i in $(find "$HOME" -type d -name '.git' | grep -v 'git-pull-a-rama'); do
	dir=$(dirname "$i")
	idgit=$(basename "$dir")
	printf "Checking %-45s" "$idgit"
	read -r -p "Continue? (Y/N)" -n 1 confirm
	if [[ $confirm == [yY] ]]; then
		printf "\\n"
		cd "$dir" && "$gitloc" pull
	else
		printf "\\n"
		echo "SKIPPING"
	fi
done

for i in $(find "$HOME" -type d -name '.git' | grep 'git-pull-a-rama'); do
	dir=$(dirname "$i")
	idgit=$(basename "$dir")
	printf "Checking %s\\n" "$idgit"
	cd "$dir" && "$gitloc" pull
done

