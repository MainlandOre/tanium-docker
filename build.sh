#!/usr/bin/env bash

usage() {
cat << EOF
usage: $0 options

Builds a docker Trolley image which includes the Tanium Client

Options:
    -h    Show help information
    -n    Name of the dockers image (default: docker.io/ubuntu)

EOF
}

NAME=docker.io/ubuntu
KEYFILE=tanium.pub
CLIENTFILE=taniumclient_6.0.314.1579-ubuntu16_amd64.deb

while getopts "h:n:" OPTION; do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        n) NAME=$OPTARG;;
    esac
done

if [ ! -e "$KEYFILE" ]; then
    echo
    echo "ERROR: Missing Tanium Client key file"
    echo
    usage
    exit 1
fi

./clean.sh $NAME


echo ""
echo Preparing docker image
DOCKERFOLDER=docker
CLIENTFOLDER=$DOCKERFOLDER/TaniumClient
mkdir $CLIENTFOLDER
cp -f $KEYFILE $CLIENTFOLDER/tanium.pub
cp -f $DOCKERFOLDER/TaniumClient.ini $CLIENTFOLDER/TaniumClient.ini
cp -f $CLIENTFILE $DOCKERFOLDER/$CLIENTFILE

echo ""
echo Building docker image
cd $DOCKERFOLDER
docker build -t $NAME .

echo ""
echo Image ready
echo ""
