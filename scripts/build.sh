#!/bin/bash

source scripts/variables.sh
source scripts/buildroot.sh
source scripts/debian.sh

initBuildroot

if [[ $INTERACTIVE -eq 1 ]]; then
  pushd output/buildroot
  make menuconfig
  make linux-menuconfig
  popd
fi

buildKernel
saveBootArtifact
echo "KERNEL BUILD DONE"

case $FLAVOR in
  minimal)
    buildBuildrootRootFS
    saveBuildrootRootFS
    echo "MINI ROOTFS BUILD DONE"
    ;;
  debian-jessie)
    createDebianRootfs jessie
    ;;
  debian-stretch)
    createDebianRootfs stretch
    ;;
  debian-sid)
    createDebianRootfs sid
    ;;
esac

exit $?
