#!/bin/sh
# start the image

echo 'stopping smilecdr...'
docker stop smilecdr-2023.05.R01
docker rm smilecdr-2023.05.R01
echo 'loading the image for smilecdr...'
docker image load -i image/smilecdr-2023.05.R01-docker.tar
docker tag smilecdr:latest  smilecdr:2023.05.R01
docker compose up -d --build