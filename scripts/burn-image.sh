#!/bin/bash

source scripts/variables.sh

sudo umount ${SD_CARD}*
sudo bmaptool copy ${IMAGE_NAME}.xz ${SD_CARD}

# echo -en "d\n2\nn\np\n2\n\n\nw\n" | sudo fdisk ${SD_CARD}
# sudo partprobe
# sudo resize2fs -f ${SD_CARD}2

exit 0
