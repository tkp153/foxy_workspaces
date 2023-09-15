#!/bin/bash

xhost +
docker run --restart always --shm-size=8000m  -it --gpus all --privileged --network host --name nakanosima --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw  nakanosima:latest

