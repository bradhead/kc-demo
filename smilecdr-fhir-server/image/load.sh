#!/bin/sh 
# load docker image and tag it.
docker image load -i smilecdr-2023.05.R02-docker.tar
docker tag smilecdr:latest smilecdr:2023.05.R02
