#!/bin/bash

REPOS=$(find -maxdepth 1 -type d -name "*.git")

for repo in $REPOS
do
    echo "Updating $repo"
    cd $repo
    git fetch -p
    cd - > /dev/null
done
