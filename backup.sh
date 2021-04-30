#!/bin/bash

# copy dot files
cp $HOME/.bashrc .
cp $HOME/.vimrc .
cp $HOME/.gitconfig .

# check git status
gs="$(git status | grep -i "modified")"
#echo "${gs}"

# if changes present
if [[ $gs == *"modified"* ]]; then
    echo "push"
fi

# push to Git
git add -u;
git commit -m "Backup `date +'%Y-%m-%d %H:%M:%S'`";
git push -u origin main
