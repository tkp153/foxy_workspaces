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
The base docker image is ***nvidia/cuda:11.3.0-cudnn8-devel-ubuntu20.04***. this Doclerfile are included these packages which are shown a list below.
### Main modules
- Ros2 (Foxy)
- ~~Azure Kinect Sensor SDK(Already build)~~ (Remove)
- Intel RealSense SDK 2.0
- openpifpaf
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
- terminator (v.2 add)
- vscode (v.2 add)

## Docker Image information
> Image Size: 22.8 GB (version:1 21.8 GB)
> Build Time: Approx: 30min(Depends on communication speed)
> X11_server: True

## Version information
> 1.0 <br>first release

> 2.0 (2022/10/27)<br>add terminator and vscode and local user in ubuntu 20.04 LTS
