FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04

ARG CUDA_VERSION=cuda-11.3
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

# ROS INSTALL (FOXY)
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
# setup timezone
RUN locale
RUN  apt update \
    &&  apt-get install -y --no-install-recommends \
    locales \
    && locale-gen en_US.UTF-8 

ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO=foxy


# setup sources.list
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
# setup keys
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" |  tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN  apt update -y \
    &&  apt upgrade -y \
    &&  apt install -y --no-install-recommends\
    ros-foxy-desktop \
    ros-foxy-ros-base\
    python3-colcon-common-extensions \
    python3-argcomplete \
    python3-vcstool \
    libbullet-dev \
    python3-flake8 \
    python3-rosdep \
    python3-vcstool \
    libsoundio-dev \
    python3-tk\
    tk-dev\
    && rm -rf /var/lib/apt/lists/* 

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

RUN mkdir -p colcon_ws/src \
    && cd colcon_ws \
    && colcon build\
    && rosdep init \
    && rosdep update \
    && echo "source ~/colcon_ws/install/local_setup.bash" >> ~/.bashrc
    
# setup turtlebot3_pkgs
RUN  apt update \
    &&  apt install -y --no-install-recommends \
    ros-foxy-gazebo-* \
    ros-foxy-cartographer \
    ros-foxy-cartographer-ros \
    ros-foxy-navigation2 \
    ros-foxy-nav2-bringup \
    ros-foxy-rviz2\
    && rm -rf /var/lib/apt/lists/*
RUN rm /bin/sh \
    && ln -s /bin/bash /bin/sh \
    &&  apt update -y \
    &&  apt upgrade -y\
    &&  apt install -y --no-install-recommends \
    ros-foxy-dynamixel-sdk \
    ros-foxy-turtlebot3* \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'export ROS_DOMAIN_ID=30 #TURTLEBOT3' >> ~/.bashrc \
    && rm /bin/sh \
    && ln -s /bin/bash /bin/sh

# setup realsense sdk
RUN echo 'export http_proxy="http://<proxy>:<port>" '
RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE ||  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
RUN  add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
RUN  apt install -y --no-install-recommends \
    librealsense2* \
    && rm -rf /var/lib/apt/lists/*

# install openpifpaf module
RUN pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
COPY requirements.txt ${PWD}
RUN pip3 install -r requirements.txt \
    && mkdir tools \
    && cd tools \
    && git clone https://github.com/openpifpaf/openpifpaf.git

RUN git clone https://github.com/tkp153/openpifpaf_ros2.git

RUN  add-apt-repository ppa:mattrose/terminator \
    &&  apt update -y \
    &&  apt install -y terminator\
    && rm -rf /var/lib/apt/lists/*

RUN cd tools \
    && git clone https://github.com/wmuron/motpy \
    && cd motpy \
    && make install-develop \
    && make test 

RUN cd tools \
    && git clone https://github.com/Megvii-BaseDetection/YOLOX.git \
    && cd YOLOX \
    && pip3 install -v -e .