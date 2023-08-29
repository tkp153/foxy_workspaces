FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04

ARG CUDA_VERSION=cuda-11.6
ARG PYTHON_VERSION=python3
ARG TZ=Asia/Tokyo

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ ${TZ}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVERS_CAPABILITIES=all

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /root

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
    && rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3.8 /usr/bin/python

ENV PATH = "/usr/local/${CUDA_VERSION}/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/${CUDA_VERSION}/lib64:$LD_LIBRARY_PATH"


# setup realsense sdk
RUN echo 'export http_proxy="http://<proxy>:<port>" '
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE ||  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
RUN  add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
RUN  apt install -y --no-install-recommends \
    librealsense2-dkms* librealsense2-utils  librealsense2-dev librealsense2-dbg \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ${PWD}
RUN pip3 install -r requirements.txt \
    && mkdir tools \
    && cd tools 

RUN git clone https://github.com/tkp153/openpifpaf_ros2.git

RUN  add-apt-repository ppa:mattrose/terminator \
    &&  apt update -y \
    &&  apt install -y terminator\
    && rm -rf /var/lib/apt/lists/*



