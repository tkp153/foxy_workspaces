FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04

LABEL version "1.0"
LABEL description " make a workspace for ros2 with openpifpaf"

RUN apt-get update && apt-get upgrade
RUN apt install git
