#!/bin/bash

# exit when any command fails
set -e

# get latest db build scripts from datatracker trunk
svn checkout https://svn.ietf.org/svn/tools/ietfdb/trunk/docker

# create data directory
mkdir data

# setup db
docker/setupdb

# update db
docker/updatedb

# create ietf_utf8.bin.tar.bz2 and copy that to sprint directory
docker/copydb
