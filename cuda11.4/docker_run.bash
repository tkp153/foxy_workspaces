#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name test --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw  foxy_kinect:2.0
