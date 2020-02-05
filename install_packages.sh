#!/bin/bash

if [ -f /etc/lsb-release ]; then
    #For ubuntu
    echo "Install xorg packages"
    PKG=(
	xauth
	x11-utils
    )
    sudo apt update
    sudo apt install -y ${PKGS[@]}
else
    #For CentOS,RHEL,fedora
    echo "Install xorg packages"
    PKG=(
	xorg-x11-xauth
	xorg-x11-utils
    )
    sudo yum check-update
    sudo yum install -y ${PKG[@]}
    #Check display server
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	sudo sed -e "s|#WaylandEnable|WaylandEnable|g" -i /etc/gdm/custom.conf
	echo "!!! Reboot and Select X11 on login !!!"
    elif [ "$XDG_SESSION_TYPE" = "tty" ]; then
	echo "Not enable display server."
    else
	echo "Enable X11."
    fi
fi
