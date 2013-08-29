#!/bin/bash

DOTFILES_DIR="`dirname \"$0\"`"

for i in $DOTFILES_DIR/*; do
	[ "$i" = "$0" ] && continue;
	DOTFILE=".`basename $i`"
	echo "Copying $DOTFILE"
	cp -n $i ~/$DOTFILE
done
