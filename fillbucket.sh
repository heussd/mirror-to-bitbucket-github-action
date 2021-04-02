#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

trap "echo 'Missing parameter'; exit 1" INT TERM EXIT
username="$1"
password="$2"
reponame="$3"
#remote="$4"
trap - INT TERM EXIT


CURL_OPTS=(-u "$username:$password" --silent)


echo "Validating BitBucket credentials..."
curl --fail "${CURL_OPTS[@]}" "https://api.bitbucket.org/2.0/user" > /dev/null || (
    echo "... failed. Most likely, the provided credentials are invalid. Terminating..."
    exit 1
)


reponame=$(echo $reponame | tr '[:upper:]' '[:lower:]')

echo "Checking if BitBucket repository \"$username/$reponame\" exists..."
curl "${CURL_OPTS[@]}" "https://api.bitbucket.org/2.0/repositories/$username/$reponame" | grep "error" > /dev/null && (
    echo "BitBucket repository \"$username/$reponame\" does NOT exist, creating it..."
    curl -X POST --fail "${CURL_OPTS[@]}" "https://api.bitbucket.org/2.0/repositories/$username/$reponame" -H "Content-Type: application/json" -d '{"scm": "git", "is_private": "true"}' > /dev/null
)


#remote=$(echo $remote | tr '[:upper:]' '[:lower:]')
#
#echo "Checking for remote \"$remote\"..."
#git remote get-url "$remote" &> /dev/null || (
#    echo "Repository has no remote \"$remote\", creating it..."
#    git remote add "$remote" https://$username@bitbucket.org/$username/$reponame.git
#)


echo "Pushing to remote..."
git push https://"$username:$password"@bitbucket.org/$username/$reponame.git --force --mirror
