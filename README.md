# Tanium Docker

We have a need to simulate the Tanium Client in order to test content we are developing.  The simplest solution, for us, was to spin up the client within Docker containers.  This repository contains that work which includes a few control scripts to make things really easy.

Luckily for us, ubuntu is well supported within docker and that just so happens to be what our trolleys run to keep track of their status.

## Getting Started

1. This will compile an image which includes the TaniumClient and a simple boot script.
```
./build.sh
```

2. Start up 5 containers then go checkout your Tanium Console under System Status... you should see your new containers checking in.
```
./start.sh -s 192.168.1.2
```
> The ip address here is the address of our Tanium Server where the client will start talking into.
> If you'd like to have more or less containers, add `-c #` where # is the number of containers to spin up.

3. (Optional) Connect to a bash prompt onto one of your containers:
```
docker exec -i -t d5f491f505ca /bin/bash
```
> The `d5f491f505ca` is the container id as displayed by the `./start.sh` command or identified via `docker ps -a`.

4. This will stop and delete all containers seen within `docker ps -a`.
```
./stop.sh
```

5. If you'd like to cleanup your build environment and remove any docker images built from step 1, use the command above.
```
./clean.sh
```

