#!/bin/sh
set -e

RESET="\e[0m"
BOLD_GREEN="\e[1;32m"

mods=`git.exe status -s | cut -c4- | awk -F'/' '{
if ($2!="")
	print $1
}' | sort | uniq`

for mod in $mods; do
	version=`cat "$mod/$mod.nuspec" | grep -oP '(?<=<version>).+(?=<\/version>)'`
	echo -ne "Update $BOLD_GREEN$mod to v$version$RESET? [Y/n]: "
	read -rn 1 reply
	if [ "$reply" == 'n' ]; then
		echo
		continue
	fi

	git.exe add "$mod/"
	git.exe commit -m "$mod: Update to v$version"
done
