#!/bin/bash

# We stick to jpeg images because some "sourceUrl"s do not contain a file extension
IMAGE_EXTENSION=jpeg

# Get search results via the API
# Search term: "guten morgen grüße filetype:jpeg"
SEARCH_RESULTS_JSON=$(curl "https://app.zenserp.com/api/v2/search?apikey=$ZENSERP_API_KEY&q=guten%20morgen%20gr%C3%BC%C3%9Fe%20filetype%3A$IMAGE_EXTENSION&tbm=isch&gl=DE")

# Get the number of search results 
NUM_SEARCH_RESULTS=$(echo $SEARCH_RESULTS_JSON | jq ".image_results | length")

# Get a random search result
SEARCH_RESULT_INDEX=$(($RANDOM % $NUM_SEARCH_RESULTS))

# Get the "sourceUrl" of the random search result
IMAGE_URL=$(echo $SEARCH_RESULTS_JSON | jq -r ".image_results[$SEARCH_RESULT_INDEX].sourceUrl")

# Download the actual image
curl $IMAGE_URL --output image.jpeg

# Set env vars
echo "IMAGEURL=$IMAGE_URL" >> $GITHUB_ENV
echo "IMAGEFILE=image.$IMAGE_EXTENSION" >> $GITHUB_ENV

# Logging
echo "image url: $IMAGE_URL"
echo "image file: image.$IMAGE_EXTENSION"
