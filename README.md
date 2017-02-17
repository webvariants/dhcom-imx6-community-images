DHCOM imx6 community images
===========================

This repo provides community images for the imx6 based System-on-Modules from [DHCOM](http://www.dh-electronics.com/produkt/dhcom-imx6x/)
Currently only the `minimal` flavor works, but `debian-jessie` and `debian-stretch` will hopefully follow.

## How to Build

There is a docker based build process in this repository. Therefore only docker is required to build the images.

To build the minimal flavor simply run the following line of code:
```bash
bash ./docker-based-build.sh
```
This will start building the build container image, and then continues with using this container to clone [buildroot](https://github.com/buildroot/buildroot), configure it for the imx6 architecture and include a basic set of tools, configure the kernel, and starts building everything.

In the begining you will be presented buildroots ncurses based configuration environment. You do not have to do anything here, but you can! After that, the kernel will be build. After all kernel-build dependencies being build you see a second ncurses based config environment. This time it's the kernels menuconfig. You don't need to edit anything, but  like before you can.  

If your kernel config is done, go and get a cup of coffee, or better cook a whole pot. This will take a while.

After everything is builded, a sd-card image is created, suitable to be booted from your device.

You can find it in `output/images/dhcom-imx6-minimal.img.xz`. You will also find a bmapfile which will help you save time while flashing the image to a real sd-card.

## How to Flash

First you need to find out the name of your sd-card. To do this detach your sd-card from your computer and attach it again. After this exec the `dmesg` command. The last few line should look like this:
```bash
[106995.247031] sd 1:0:0:3: [sde] 30703616 512-byte logical blocks: (15.7 GB/14.6 GiB)
[106995.252581]  sde: sde1 sde2
[106995.625141] EXT4-fs (sde2): mounting ext3 file system using the ext4 subsystem
[106995.637779] EXT4-fs (sde2): mounted filesystem with ordered data mode. Opts: (null)
[106995.656854] EXT4-fs (sde1): mounting ext3 file system using the ext4 subsystem
[106995.665014] EXT4-fs (sde1): mounted filesystem with ordered data mode. Opts: (null)
```
Here `/dev/sde` is my sd-card.

You can use the dhcom-builder docker image to flash your sd-card.

```bash
SDCARD=/dev/sde
sudo umount ${SDCARD}?
docker run \
  -v $(pwd)/output/images:/images \
  --privileged \
  dhcom-builder \
    bmaptool copy /images/dhcom-imx6-minimal.img.xz $SDCARD
```
