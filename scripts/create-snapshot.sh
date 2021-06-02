#!/bin/bash

SCRIPTDIR=$PWD/scripts
CODEDIR=trunk
CODEREPO=https://svn.ietf.org/svn/tools/ietfdb/$CODEDIR
REPO=ietf/datatracker-environment
TAG=latest
WHO=$(whoami)
WHOUID=$(id -u $WHO)
WHOGID=$(id -g $WHO)

# exit when any command fails
set -e

# checkout datatracker trunk
echo "Checkout datatracker $CODEDIR"
cd ~
PARENT=$PWD
MYSQLDIR=$PARENT/$CODEDIR/data/mysql
FILEDIR=$PARENT/$CODEDIR/data/
svn checkout -q $CODEREPO

cd $PARENT/$CODEDIR

# setup db
echo "Running setupdb"
docker/setupdb -v

# fetch latest docker image
echo "Fetching docker image '$REPO:$TAG'"
docker pull "$REPO:latest"

# run datatracker docker instance and run migrations
echo "Starting docker image"
cp "$SCRIPTDIR/init.sh" init.sh
docker run -ti --entrypoint $PARENT/$CODEDIR/init.sh \
    -v "$PARENT:/home/$WHO" -v "$MYSQLDIR:/var/lib/mysql" -e USER="$WHO" \
    -e DATADIR="$FILEDIR" -e CWD="$PARENT/$CODEDIR" \
    -e TAG="$TAG" -e FILEDIR="$FILEDIR" -e UID="$WHOUID" \
    -e GID="$WHOGID" "$REPO:$TAG"

# copy db
echo "Running copydb"
docker/copydb -v

echo "done!"
