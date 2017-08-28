#!/usr/bin/env bash

echo ""
echo Stopping docker containers
docker stop $(docker ps -q)

echo ""
echo Deleting docker containers
docker rm $(docker ps -a -q)

echo ""
