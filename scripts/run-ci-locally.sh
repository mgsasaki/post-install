#!/bin/bash

REPOS_DIR=${PWD}/..
PROJECT_NAME=${PWD##*/}

printf '\x1B[1;36mRunning job "%q" for project "%q"...\x1B[0m\n' "$1" "$PROJECT_NAME"

gitlab-runner exec docker \
	--docker-volumes $REPOS_DIR:$REPOS_DIR \
	--docker-volumes /tmp/gitlab-runner-cache/$PROJECT_NAME:/tmp/gitlab-runner-cache \
	--cache-dir /tmp/gitlab-runner-cache \
        --env CI_MBED_PACKAGE=framework-mbed \
	$1
