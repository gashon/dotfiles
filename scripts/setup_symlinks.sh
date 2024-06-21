#!/bin/bash

# This script symlinks all dotfiles to the home directory

if [ "$(basename "$(pwd)")" != "dotfiles" ]; then
    echo "Please run this script in dotfiles directory"
    exit 1
fi

home_dots=$(find . -name ".*" -type f -not -name ".git" -maxdepth 1)

config_dots=$(find .config -maxdepth 1 -mindepth 1)

for f in $home_dots; do
    ln -s "$f" ~/"$f"
done

for d in $config_dots; do
	dir_name=$(basename "$d")
    ln -s "$d" ~/.config/"$dir_name"
done

