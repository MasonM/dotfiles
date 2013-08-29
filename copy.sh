#!/bin/bash

DOTFILES_DIR="`dirname \"$0\"`"

for i in $DOTFILES_DIR/*; do
	[ "$i" = "$0" ] && continue;
	DOTFILE=".`basename $i`"
	if [ -a ~/$DOTFILE ]; then
		echo "$DOTFILE already exists";
		continue;
	fi
	echo "Copying $DOTFILE"
	cp -n $i ~/$DOTFILE
done
