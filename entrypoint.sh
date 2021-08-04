#!/bin/sh
set -e

SOURCE_REPO=https://${INPUT_TARGET_USERNAME}:${INPUT_TARGET_TOKEN}@${INPUT_TARGET_URL#https://}
DESTINATION_REPO=https://${INPUT_DESTINATION_USERNAME}:${INPUT_DESTINATION_TOKEN}@${INPUT_DESTINATION_URL#https://}

git clone --mirror "$SOURCE_REPO" && cd `basename "$SOURCE_REPO"`
git remote set-url --push origin "$DESTINATION_REPO"
git fetch -p origin
# Exclude refs created by GitHub for pull request.
git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
git push --mirror