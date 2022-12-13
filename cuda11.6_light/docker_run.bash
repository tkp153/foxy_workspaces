#!/bin/bash

xhost +
docker run --restart always  -it --gpus all --privileged --network host --name foxy_116_pifpaf --group-add video --env DISPLAY --volume /tmp/.X11-unix:/tmp/.X11-unix:rw --volume /dev:/dev:rw --volume ${PWD}:/root/WORKDIR:rw  cuda11.6_pif_check:latest
