#!/bin/bash

source scripts/variables.sh
source scripts/buildroot.sh
source scripts/debian.sh

case $FLAVOR in
  minimal)
    buildBuildrootRootFS
    saveBuildrootRootFS
    ;;
  jessie)
    createDebianRootfs jessie ;;
  stretch)
    createDebianRootfs stretch ;;
  sid)
    createDebianRootfs sid ;;
esac

exit $?
