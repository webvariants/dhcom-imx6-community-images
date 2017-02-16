#!/bin/bash

source scripts/variables.sh
source scripts/buildroot.sh

initBuildroot

if [[ $INTERACTIVE -eq 1 ]]; then
  pushd output/buildroot
  make menuconfig
  make linux-menuconfig
  popd
fi

buildKernel
saveBootArtifact

exit $?
