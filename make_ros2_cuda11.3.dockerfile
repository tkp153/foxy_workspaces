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
    python3-pip\
    software-properties-common \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update -y\
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends\
    libglvnd-dev libglvnd-dev\
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python

ENV PATH = "/usr/local/${CUDA_VERSION}/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH"

# ROS INSTALL (FOXY)
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO=foxy


# setup sources.list
RUN echo "deb http://packages.ros.org/ros2/ubuntu focal main" > /etc/apt/sources.list.d/ros2-latest.list
# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt update \
    apt upgrade \
    spt install -y --no-install-recommends\
    ros-foxy-desktop \
    ros-foxy-ros-base\
    python3-colcon-common-extensions \
    python3-argcomplete \
    python3-vcstool \
    rm -rf /var/lib/apt/lists/* \
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

RUN mkdir -p colcon_ws/src \
    && cd colcon_ws \
    colcon build

RUN apt update \
    apt install -y --no-install-recommends \
    ros-foxy-gazebo-* \
    ros-foxy-cartographer \
    ros-foxy-cartographer-ros \
    ros-foxy-navigation2 \
    ros-foxy-nav2-bringup \
    && source ~/.bashrc \
    && apt install -y --no-install-recommends \
    ros-foxy-dynamixel-sdk \
    ros-foxy-turtlebot3* \
    rm -rf /var/lib/apt/lists/*

RUN echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc \
    && source ~/.bashrc

