# rpi

Airplay with Raspberry PI

## Process

sudo apt update

sudo apt upgrade

sudo rpi-update

sudo reboot

sudo apt-get install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

sudo apt-get install git

git clone https://github.com/FD-/RPiPlay.git

cd RPiPlay

sudo apt-get install cmake

sudo apt-get install libavahi-compat-libdnssd-dev

sudo apt-get install libplist-dev

sudo apt-get install libssl-dev

mkdir build

cd build

cmake --DCMAKE\_CXX\_FLAGS="-O3" --DCMAKE\_C\_FLAGS="-O3" ..

make -j2

sudo apt install libgles-dev libegl-dev

sudo ln -s /usr/lib/arm-linux-gnueabihf/libGLESv2.so /usr/lib/libbrcmGLESv2.so

sudo ln -s /usr/lib/arm-linux-gnueabihf/libEGL.so /usr/lib/libbrcmEGL.so

comment out this line _in_ /boot/config.txt

```
dtoverlay=vc4-kms-v3d
```

sudo reboot

./rpiplay -n "rpiplay-01" -vr rpi -ar rpi -a hdmi
