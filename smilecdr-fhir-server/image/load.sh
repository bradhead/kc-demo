#!/bin/sh 
# load docker image and tag it.
docker image load -i smilecdr-2022.11.R03-docker.tar
docker tag smilecdr:latest smilecdr:2022.11.R03
