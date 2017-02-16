#!/bin/bash

# example: createDebianRootfs stretch
function createDebianRootfs {
  flavor=${1}
  dir=output/debian_${flavor}

  sudo rm -rf ${dir}
  mkdir ${dir}

  sudo debootstrap --foreign --arch armhf ${flavor} ${dir} http://ftp.debian.org/debian/
  sudo cp /usr/bin/qemu-arm-static ${dir}/usr/bin

  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  LC_ALL=C LANGUAGE=C LANG=C \
    sudo chroot ${dir} /debootstrap/debootstrap --second-stage

  DEBIAN_FRONTEND=noninteractive \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  LC_ALL=C LANGUAGE=C LANG=C \
    sudo chroot ${dir} dpkg --configure -a

  sudo cp -rf rootfs-overlay/* ${dir}/
  sudo tar cf output/rootfs.tar -C ${dir} .
}
