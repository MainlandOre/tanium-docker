#!/usr/bin/env bash

echo ""
echo Stopping services
./stop.sh

echo Cleaning up build folder
rm -rf docker/Tools
rm -rf docker/TaniumClient

echo Removing docker image
docker rmi -f docker.io/ubuntu