#!/usr/bin/env bash

# Authentication
JSON="{ \"username\": \"$DOCKER_USERNAME\", \"password\": \"$DOCKER_PASSWORD\" }"
TOKEN=$(curl --silent --header 'Content-Type: application/json' --data "$JSON" \
    https://hub.docker.com/v2/users/login | jq -r '.token')

echo $TOKEN

# Execution
GAME="$1"
CMD=$(curl --header "Authorization: Bearer $TOKEN" https://hub.docker.com/api/build/v1/source/\?image=lanlords/$GAME | jq -r '.objects[0].state')

echo $CMD