#!/usr/bin/env bash

SERVER=
COUNT=5
while getopts “s:c:” OPTION; do
     case $OPTION in
         s) SERVER=$OPTARG;;
         c) COUNT=$OPTARG;;
     esac
done

if [ -z $SERVER ]; then
    echo
    usage
    exit 1
fi

echo "Starting ${COUNT} containers with the Tanium server (${SERVER})"
cd docker

COUNTER=0
while [ $COUNTER -lt $COUNT ]; do
    hostname=tanium${COUNTER}.ubuntu
    ID=$(docker run -d -e SERVER_HOST=${SERVER} -h ${hostname} docker.io/ubuntu)
    echo "Starting ${hostname} (${ID:0:12})"
    let COUNTER=COUNTER+1
done
echo ""