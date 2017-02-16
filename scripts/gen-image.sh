#!/bin/bash

source scripts/variables.sh

function getCurrentLoopDevice() {
  sudo losetup -l -ONAME|tail -1
}

function createImage() {
  rm ${IMAGE_NAME}.*
  fallocate -l ${ABS_SIZE} ${IMAGE_NAME}
  echo -en ",${PART_ONE_SIZE}\n,\n" | sudo sfdisk ${IMAGE_NAME}
  sudo losetup -d /dev/loop?
  sudo losetup -fP ${IMAGE_NAME}
  sudo mkfs.ext3 -F -L boot $(getCurrentLoopDevice)p1
  sudo mkfs.ext3 -F -L rootfs $(getCurrentLoopDevice)p2
}

function copyContents() {
  sudo mkdir -p /tmp/boot /tmp/rootfs
  sudo mount $(getCurrentLoopDevice)p1 /tmp/boot
  sudo mount $(getCurrentLoopDevice)p2 /tmp/rootfs
  sudo tar xf output/boot.tar -C /tmp/boot
  sudo tar xf output/rootfs.tar -C /tmp/rootfs
  sudo umount /tmp/boot /tmp/rootfs
  sudo losetup -d $(getCurrentLoopDevice)
}

function packImage() {
  bmaptool create ${IMAGE_NAME} > ${IMAGE_NAME}.bmap
  pxz -f ${IMAGE_NAME}
}

createImage
copyContents
packImage

exit $?
