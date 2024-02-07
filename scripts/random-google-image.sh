#!/bin/bash

# We stick to jpeg images because some "sourceUrl"s do not contain a file extension
IMAGE_FILE_EXTENSION=jpg

# Get search results via the API
# Search term: "guten morgen grüße filetype:jpeg"
SEARCH_RESULTS_JSON=$(curl "https://app.zenserp.com/api/v2/search?apikey=$ZENSERP_API_KEY&q=Guten%20Morgen%20Cringe%20\"jpg\"&tbm=isch")

# Get the number of search results 
NUM_SEARCH_RESULTS=$(echo $SEARCH_RESULTS_JSON | jq ".image_results | length")

# Get a random search result
SEARCH_RESULT_INDEX=$(($RANDOM % $NUM_SEARCH_RESULTS))

# Get the "sourceUrl" of the random search result
IMAGE_URL=$(echo $SEARCH_RESULTS_JSON | jq -r ".image_results[$SEARCH_RESULT_INDEX].sourceUrl")

IMAGE_FILE="image.$IMAGE_FILE_EXTENSION"

# Download the actual image
curl $IMAGE_URL --output $IMAGE_FILE

# Set env vars
echo "IMAGEURL=$IMAGE_URL" >> $GITHUB_ENV
echo "IMAGEFILE=$IMAGE_FILE" >> $GITHUB_ENV

# Logging
echo "image url: $IMAGE_URL"
echo "image file: $IMAGE_FILE"
