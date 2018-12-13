#!/bin/bash
WORKDIR=$(dirname "$0")
source $WORKDIR/config.sh

for ZONE in `cat $ZONES_FILE`; do
  cli53 import \
    --profile=$AWS_PROFILE \
    --file $ORIGINAL_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION \
    --replace --wait $ZONE
done