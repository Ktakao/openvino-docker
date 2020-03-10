# openvino-docker
Create a CentOS based openvino environment on a docker

## build docker image

``` bash
docker-compose build
```
## Using the image
1. If you want to display the calculation result in the GUI, Run the script "install_packages.sh".

``` bash
sudo ./install_packages.sh
```

2. Provide X access controll on your computer from remote. but this command is so dangruous. You have disabled access control to X on your computer. If you provide X access controll on your computer from remote, You must access controll is limited and disable the always permissions Once that is done.

``` bash
xhost +[remote machine's IP]
```

3. Run OpenVINO on docker container and attach the container.

``` bash
docker-compose run openvino-cent bash
```

There is a case where X fording from a remote computer does not work. Start the container in this command that case.
``` bash
docker run -it --privileged --net=host -v /dev:/dev -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/root/.Xauthority:rw -v /host:/host openvino-cent bash
```

## running demo
Install Openvino toolkit and demo packages on `/opt/intel/openvino`
Please read this to know how to use.
https://docs.openvinotoolkit.org/latest/_demos_README.html

### Sample: running Security Barrier Camera

``` bash
cd /opt/intel/openvino/deployment_tools/demo
./demo_security_barrier_camera.sh -d GPU
```
