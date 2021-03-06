#!/bin/bash
WORKDIR=$(dirname "$0")
source $WORKDIR/test_config.sh

for ZONE in `cat $ZONES_FILE`; do
  cli53 import \
    --profile=$AWS_PROFILE \
    --file $CHANGED_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION \
    --replace --wait $ZONE
done