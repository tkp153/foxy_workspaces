FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04

ARG CUDA_VERSION=cuda-11.3
ARG PYTHON_VERSION=python3
ARG TZ=Asia/Tokyo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ ${TZ}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVERS_CAPABILITIES=all

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

LABEL version "1.0"
LABEL description " make a workspace for ros2 with openpifpaf"



RUN apt  update -y \ 
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends\
    git \
    vim \
    curl \
    wget \
    gnupg2\
    lsb-release\
    mesa-utils \
    python3-pip

RUN apt-get update -y\
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends\
    libglvnd-dev libglvnd-dev\
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python

ENV PATH = "/usr/local/${CUDA_VERSION}/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH"

# ROS INSTALL (FOXY)