XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

#        --device /dev/video0 \ # for webcam
#        --device /dev/bus/usb \ # for flir camera

docker run  --gpus '"device=0,1"' --rm -it \
        --volume=$XSOCK:$XSOCK:rw \
        --volume=$XAUTH:$XAUTH:rw \
        --env="XAUTHORITY=${XAUTH}" \
        --env="DISPLAY=${DISPLAY}" \
        --env QT_X11_NO_MITSHM=1 \
        --env="NVIDIA_DRIVER_CAPABILITIES=all" \
        -v ${PWD}/..:/QT \
        -w /QT \
        --name qt-con \
   qt:latest
#        --net=host \

