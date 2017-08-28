#!/usr/bin/env bash

# cwd to the TaniumClient root
cd /opt/Tanium/TaniumClient

if [ ! -f tanium.pub ]; then
    echo "Missing tanium.pub - Exiting"
    exit 1
fi

if [ -z "$SERVER_HOST" ]; then
    # Really need this to do anything
    echo "Server host is required - Exiting"
    exit 1
fi

# Allow custom port, default to 17472
PORT="${SERVER_PORT:-17472}"

sed -i -e "s/{{SERVER_HOST}}/$SERVER_HOST/g" TaniumClient.ini
sed -i -e "s/{{SERVER_PORT}}/$PORT/g" TaniumClient.ini

# off we go
./TaniumClient -d