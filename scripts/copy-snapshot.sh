#!/bin/bash

cd ~/$CODEDIR

# copy db
echo "Running copydb"
docker/copydb -v

echo "Done!"
