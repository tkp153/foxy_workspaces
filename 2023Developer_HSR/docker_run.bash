#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name hsr_dev_testing_container --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw  hsr_dev_container:latest
