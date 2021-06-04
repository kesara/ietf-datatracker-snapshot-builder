#!/bin/bash

echo "Running copydb"

cd ~/$CODEDIR/data/

echo "Working direcory: $PWD"

echo "Building tarball"
tar cjfv --ignore-failed-read ietf_utf8.bin.tar.bz2 mysql

ls -la ietf_utf8.bin.tar.bz2

echo "Copying tarball to upstream server"
scp ietf_utf8.bin.tar.bz2 $UPSTREAMSERVER:$UPSTREAMPATH

echo "Done!"
