#!/bin/bash

REPOSITORY=$REPO

echo "REPO ${REPOSITORY}"
echo "TOKEN ${TOKEN}"


cd /home/docker/actions-runner

./config.sh --url https://github.com/${REPOSITORY} --token ${TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
