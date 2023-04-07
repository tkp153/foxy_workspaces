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
The base docker image is ***nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04(cu113) and nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04(cu116)***. this Doclerfile are included these packages which are shown a list below.
### Main modules
- Ros2 (Foxy)
- Azure Kinect Sensor SDK(Already build)
- Intel RealSense SDK 2.0
- openpifpaf -> version 0.13.6
- Cuda 11.3
- Pytorch 1.12.1 with cuda (included torch vision and torchaudio) 
- opencv
- ~~motpy~~ <br> remove
- ~~yolox~~ <br> remove
### Sub modules
- TurtleBot3 packages (Foxy version)
  - Maybe all packages for TurtleBot3 
- nano
- gazebo11
- gedbi
- pcmanfm
- terminator (v.2 add)

## Docker Image information
> Image Size: 22.2 GB (version:1 21.8 GB)
> Build Time: Approx: 30min(Depends on communication speed)
> X11_server: True

## Version information
> 1.0 <br>first release

> 2.0 (2022/10/27)<br>add terminator

> 2.01 (2022/11/11) <br> add YOLOX,motpy

>2.02 (2022/11/14) <br> remove Yolox and MOTPY lock openpifpaf version to 0.13.6

>2.03 (2022/11/14) <br>

> - add v4l2_camera_node

> - reduce file size

>2.04(2022/11/16) <br> 1.add cuda 11.6 version dockerfile <br> 2.restore Kinect Azure SDK<br>3. reduce image size

> 2.05(2023/4/7) <br> 1. add 2023Developer_HSR Dockerfiles <br> 2. add 2023Developer_HSR docker run bash script
> 

