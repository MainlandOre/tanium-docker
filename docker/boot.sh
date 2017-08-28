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

# Write the trolley id out to disk; we will simply use the docker id to keep thing simple
if [ ! -f /id ]; then
    cat /proc/self/cgroup | grep -o -e "docker-.*.scope" | head -n 1 | sed "s/docker-\(.*\).scope/\\1/" | cut -c1-12 > /id
fi

# Initialize the trolley database which we expect to always exist on our trolleys
if [ ! -f /trolley.db ]; then
    sqlite3 /trolley.db "CREATE TABLE events (id INTEGER PRIMARY KEY, message varchar(255) not null, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL)"
    sqlite3 /trolley.db "INSERT INTO events (message) VALUES('database initialized')"
fi

# off we go
./TaniumClient -d
