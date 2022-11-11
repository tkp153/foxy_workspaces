#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name foxy_cuda_realsense_devel --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw  workspace:1.0
