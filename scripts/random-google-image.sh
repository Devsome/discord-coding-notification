#!/bin/bash

RESULT=$(curl "https://app.zenserp.com/api/v2/search?apikey=916d7170-8019-11ec-8464-fd5d1d7aefa5&q=Guten%20Morgen&tbm=isch&gl=DE")
LEN=$(echo $RESULT | jq ".image_results | length")
OFFSET=$(echo $(($RANDOM % $LEN)))
LINK=$(echo $RESULT | jq ".image_results[$OFFSET].sourceUrl")
LINK_STRIPPED=$(echo $LINK | sed "s/\"//g")
echo "IMAGEURL=$LINK_STRIPPED" >> $GITHUB_ENV
echo "image url: $LINK_STRIPPED"
filename=$(basename -- "$LINK_STRIPPED")
extension="${filename##*.}"
ext=$(echo $extension | cut -c1-3)
curl $LINK_STRIPPED --output image.$ext
echo "IMAGEFILE=image.$ext" >> $GITHUB_ENV

