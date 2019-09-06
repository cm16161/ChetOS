#!/bin/bash

cd /sources
tar -Jxf lfs-bootscripts-20190524.tar.xz
cd lfs-bootscripts-20190524
make install
cd /sources
rm -rf lfs-bootscripts-20190524

mv -v ifconfig.eth0 /etc/sysconfig/
mv -v resolv.conf /etc/
mv -v hostname /etc/
mv -v inittab /etc/
mv -v clock /etc/sysconfig/
mv -v profile /etc/
mv -v inputrc /etc/
mv -v shells /etc/
