# ros2_cuda11.3_workspaces
## Minimum environment 
In this package we need this specs and packages on your host machine
- nvidia gpu
- AMD64 CPU 
- nvidia drivers
- x11(X Windows System ver.11 )
- NVIDIA container toolkit
- Docker
- AMD64 CPU


## How to use this package

 1. clone this
  ```
  git clone https://github.com/tkp153/ros2_cuda11.3_workspaces.git
  ```
 2. build docker file
  ```
  docker build ./ -t {containername:tag}
  #example:
  docker build ./ -t workspace:1.0
  ```
 3. run it.
  ```
  chmod +x docker_run.bash
  ./docker_run.bash
  ```

## What modules are included
The base docker image contains is ***nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04***.And this package , I customized it from this.The modules included in this packages are shown a list below.
### Main modules
- Ros2 (Foxy)
- Azure Kinect Sensor SDK(Already build)
- Intel RealSense SDK 2.0
- openpifpaf(Already check to move this package in docker contains)
- Cuda 11.3
- Pytorch 1.12.1 with cuda (included torch vision and torchaudio) 
- opencv
### Sub modules
- TurtleBot3 packages (Foxy version)
  - Maybe all packages for TurtleBot3 
- nano
- gazebo11
- gedbi
- pcmanfm

## Docker Image information
> Image Size: 21.8 GB
> Build Time: Approx: 30min(Depends on communication speed)
> X11_server: True
