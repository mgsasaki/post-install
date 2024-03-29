#!/bin/bash

REPOS_DIR=${PWD}/..
PROJECT_NAME=${PWD##*/}
CURRENT_BRANCH=$(git branch --show-current)
CURRENT_BRANCH_SLUG=${CURRENT_BRANCH//\//-}
CURRENT_COMMIT_SHORT=$(git rev-parse --short HEAD)

printf '\x1B[1;36mRunning job "%q" for project "%q"...\x1B[0m\n' "$1" "$PROJECT_NAME"

gitlab-runner exec docker \
	--docker-volumes $REPOS_DIR:$REPOS_DIR \
	--docker-volumes /tmp/gitlab-runner-cache/$PROJECT_NAME:/tmp/gitlab-runner-cache \
	--docker-cache-dir /tmp/gitlab-runner-cache \
	--cache-dir /tmp/gitlab-runner-cache \
        --env CI_MBED_PACKAGE=framework-mbed \
	--env CI_API_V4_URL=https://gitlab.com/api/v4 \
	--env CI_COMMIT_REF_SLUG=$CURRENT_BRANCH_SLUG \
	$1
