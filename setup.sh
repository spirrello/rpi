#!/usr/bin/env bash

prep () {
    echo "starting prep work"
    echo " "
    apt update
    apt upgrade -y
    rpi-update
    echo "rebooting"
    reboot
}

install () {
    echo "installing rpiplay"
    echo " "
    sudo apt-get install vim git libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev -y

    git clone https://github.com/FD-/RPiPlay.git

    cd RPiPlay

    sudo apt-get install cmake libavahi-compat-libdnssd-dev libplist-dev libssl-dev -y

    mkdir build

    cd build

    cmake --DCMAKE\_CXX\_FLAGS="-O3" --DCMAKE\_C\_FLAGS="-O3" ..

    make -j2

    sudo apt install libgles-dev libegl-dev -y

    sudo ln -s /usr/lib/arm-linux-gnueabihf/libGLESv2.so /usr/lib/libbrcmGLESv2.so

    sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so /usr/lib/libbrcmEGL.so

    sudo sed -i "s/dtoverlay=vc4-kms-v3d/#dtoverlay=vc4-kms-v3d/g" /boot/config.txt


    # call this function to setup systemd service
    setup_systemd

    reboot
}

setup_systemd () {
    sudo cp ../../rpiplay.service /etc/systemd/system/rpiplay.service

    sudo systemctl daemon-reload

    sudo systemctl enable rpiplay.service

    sudo systemctl start rpiplay
}

while [ -n "$1" ]; do # while loop starts

	case "$1" in

	-prep)
    prep
    ;;

	-install)
	install
    ;;

    -systemd)
	setup_systemd
    ;;

	esac

	shift

done
