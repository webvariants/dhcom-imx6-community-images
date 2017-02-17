#!/bin/bash

function initBuildroot() {
  git clone --branch 2017.02-rc1 --depth=1 https://github.com/buildroot/buildroot output/buildroot
  cp configs/buildroot-config output/buildroot/.config
  cp configs/linux-config output/buildroot/linux-config
  mkdir -p output/ssh/ output/images/
  yes '' | ssh-keygen -f output/ssh/master-key
  mkdir -p rootfs-overlay/root/.ssh/
  cat $(pwd)/output/ssh/master-key.pub > rootfs-overlay/root/.ssh/authorized_keys
  cp -rf rootfs-overlay output/buildroot/
  cp -rf patches output/buildroot/
}

function buildKernel() {
  pushd output/buildroot
  make linux
  popd
}

function buildBuildrootRootFS() {
  pushd output/buildroot
  make
  popd
}

function saveBootArtifact() {
  mkdir -p output/boot-partition
  cp -rf boot-template/* output/boot-partition/
  cp output/buildroot/output/images/zImage output/boot-partition/
  tar cfv output/boot.tar -C output/boot-partition/ .
}

function saveBuildrootRootFS() {
  ln -sf buildroot/output/images/rootfs.tar output/rootfs.tar
}
