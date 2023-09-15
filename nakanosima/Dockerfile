FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

ARG CUDA_VERSION=cuda-11.6
ARG PYTHON_VERSION=python3
ARG TZ=Asia/Tokyo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ ${TZ}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVERS_CAPABILITIES=all

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


RUN  apt update -y \ 
    &&  apt-get upgrade -y \
    &&  apt-get install -y --no-install-recommends\
    git \
    vim \
    curl \
    wget \
    gnupg2\
    lsb-release\
    mesa-utils \
    python3-pip\
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

RUN  apt-get update -y\
    &&  apt-get upgrade -y \
    &&  apt-get install -y --no-install-recommends\
    libglvnd-dev libglvnd-dev\
    libgl1-mesa-dev \
    libegl1-mesa-dev \
    libgles2-mesa-dev \
    dirmngr \
    libssl-dev \
    libusb-1.0-0-*\
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libglu1-mesa-dev \    
    curl \
    python3 \
    sudo\
    nano \
    python3-dev \
    ca-certificates \
    gdebi \
    pcmanfm\
    cmake \
    make \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python

#RealsenseSDK install
ENV PATH = "/usr/local/${CUDA_VERSION}/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH"
RUN git clone https://github.com/IntelRealSense/librealsense.git
WORKDIR librealsense 
RUN pwd
RUN mkdir build
WORKDIR build
RUN pwd
RUN cmake ../
RUN sudo make uninstall && make clean && make && sudo make install

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
RUN apt install -y librealsense2-udev-rules

# Install ROS2
RUN apt update \
  && apt install -y --no-install-recommends \
     curl gnupg2 lsb-release python3-pip vim wget build-essential ca-certificates

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update  \
  && apt upgrade  -y\
  && DEBIAN_FRONTEND=noninteractive \
  && apt install -y --no-install-recommends \
     ros-humble-desktop \
  && rm -rf /var/lib/apt/lists/*

RUN bash /opt/ros/humble/setup.sh 