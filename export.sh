#!/bin/bash
WORKDIR=$(dirname "$0")
source $WORKDIR/config.sh

for ZONE in `cat $ZONES_FILE`; do
  cli53 export $ZONE \
    --profile=$AWS_PROFILE > $ORIGINAL_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION;
done