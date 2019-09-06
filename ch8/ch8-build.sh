#!/bin/bash
PARALLEL_JOBS=16


cd /sources
cd linux-5.2.8
make mrproper
make defconfig
make -j $PARALLEL_JOBS
make modules_install
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-5.2.8-lfs-9.0
cp -iv System.map /boot/System.map-5.2.8
cp -iv .config /boot/config-5.2.8
install -d /usr/share/doc/linux-5.2.8
cp -r Documentation/* /usr/share/doc/linux-5.2.8

install -v -m755 -d /etc/modprobe.d
mv -v usb.conf /etc/modprobe.d/

mv -v lsb-release /etc/
