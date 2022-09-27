#!/bin/bash

# https://stackoverflow.com/questions/4783599/rebasing-a-git-merge-commit

git tag BACKUP_DEVELOPMENT_BEFORE_REBASE

git checkout -b correct-history # create new branch to save development (local merged) for future
git rebase --strategy=ours --rebase-merges origin/development

git checkout development # return to our development (default) branch
git merge origin/development # merge remote changes on top of our development

git reset --soft correct-history
git commit --amend

git branch -D correct-history
