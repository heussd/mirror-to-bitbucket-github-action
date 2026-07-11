#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

trap "echo 'Missing parameter'; exit 1" INT TERM EXIT
username="$1"
password="$2"
reponame="$3"
trap - INT TERM EXIT

spacename="$username"
if [ $# -ge 4 ]; then
    spacename="$4"
fi

reponame=$(echo "$reponame" | tr '[:upper:]' '[:lower:]')

echo "Pushing to remote..."
git push https://"$username:$password"@bitbucket.org/"$spacename"/"$reponame".git --all --force
