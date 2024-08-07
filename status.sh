#!/usr/bin/env bash

# Authentication
JSON="{ \"username\": \"$DOCKER_USERNAME\", \"password\": \"$DOCKER_PASSWORD\" }"
TOKEN=$(curl --silent --header 'Content-Type: application/json' --data "$JSON" \
    https://hub.docker.com/v2/users/login | jq -r '.token')

# Execution
GAME="$1"
CMD="curl --silent --header \"Authorization: Bearer $TOKEN\" https://hub.docker.com/api/build/v1/source/\?image=lanlords/$GAME | jq -r '.objects[0].state'"
STARTED="0"

while :
do

    if [ "$STARTED" == "0" ]
    then

        OUTPUT="$(eval $CMD)"
        if [ "$OUTPUT" == "Building" ]; then
            echo "[status: $OUTPUT] Docker Build has started! Waiting to finish."
            STARTED="1"
         else
            echo "[status: $OUTPUT] Docker Build has not yet started."
        fi

    else

        OUTPUT="$(eval $CMD)"
        if [ "$OUTPUT" == "Success" ]; then
            echo "[status: $OUTPUT] Docker Build has finished!"
            exit 0
        elif [ "$OUTPUT" == "Failed" ]; then
            echo "[status: $OUTPUT] Docker build failed!"
            exit 1
        else
            echo "[status: $OUTPUT] Docker Build is still running."
        fi

    fi

    # wait for 5 seconds
    sleep 5

done