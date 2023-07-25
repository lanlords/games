#!/usr/bin/env bash

GAME="$1"
CMD="curl -s https://hub.docker.com/api/build/v1/source/\?image=lanlords/$GAME | jq -r '.objects[0].state'"
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