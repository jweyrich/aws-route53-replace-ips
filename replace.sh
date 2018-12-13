#!/bin/bash
WORKDIR=$(dirname "$0")
source $WORKDIR/config.sh

for ZONE in `cat $ZONES_FILE`; do
  cp "$ORIGINAL_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION" "$CHANGED_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION"
  for MAP in `cat $MAP_FILE`; do
    IFS=$MAP_SEPARTOR ips=($MAP); FROM=${ips[0]}; TO=${ips[1]}; unset IFS
    echo "Changing $ZONE: $FROM -> $TO"
    sed -i '' 's/'$FROM'$/'$TO'/g' "$CHANGED_ZONES_FOLDER/$ZONE.$ZONE_FILE_EXTENSION"
  done;
done

diff -u $ORIGINAL_ZONES_FOLDER $CHANGED_ZONES_FOLDER > diff.patch