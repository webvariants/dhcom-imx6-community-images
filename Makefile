# Toplevel Makefile

docker-build:
	bash docker-based-build.sh

build: build-kernel build-rootfs

build-kernel: output/boot.tar
output/boot.tar:
	bash scripts/build-kernel.sh

build-rootfs: output/rootfs.tar
output/rootfs.tar:
	bash scripts/build-rootfs.sh

image: output/images/dhcom-imx6.img.xz
output/images/dhcom-imx6.img.xz: output/boot.tar output/rootfs.tar
	bash scripts/gen-image.sh

burn: output/images/dhcom-imx6.img.xz
	bash scripts/burn-image.sh

# shortcuts
minimal: prepare-minimal build image
	mv output/images/dhcom-imx6.img.xz output/images/dhcom-imx6-minimal.img.xz
	mv output/images/dhcom-imx6.img.bmap output/images/dhcom-imx6-minimal.img.bmap

# WIP
debian-jessie: prepare-debian-jessie build image
	mv output/images/dhcom-imx6.img.xz output/images/dhcom-imx6-jessie.img.xz
	mv output/images/dhcom-imx6.img.bmap output/images/dhcom-imx6-jessie.img.bmap
debian-stretch: prepare-debian-stretch build image
	mv output/images/dhcom-imx6.img.xz output/images/dhcom-imx6-stretch.img.xz
	mv output/images/dhcom-imx6.img.bmap output/images/dhcom-imx6-stretch.img.bmap
debian-sid: prepare-debian-sid build image
	mv output/images/dhcom-imx6.img.xz output/images/dhcom-imx6-sid.img.xz
	mv output/images/dhcom-imx6.img.bmap output/images/dhcom-imx6-sid.img.bmap

prepare-minimal:
	sed -i -E "s/^export FLAVOR=[[:alnum:]]*/export FLAVOR=minimal/g" scripts/variables.sh
	-rm -f output/rootfs.tar

# WIP
prepare-debian-jessie:
	sed -i -E "s/^export FLAVOR=[[:alnum:]]*/export FLAVOR=jessie/g" scripts/variables.sh
	-rm -f output/rootfs.tar
prepare-debian-stretch:
	sed -i -E "s/^export FLAVOR=[[:alnum:]]*/export FLAVOR=stretch/g" scripts/variables.sh
	-rm -f output/rootfs.tar
prepare-debian-sid:
	sed -i -E "s/^export FLAVOR=[[:alnum:]]*/export FLAVOR=sid/g" scripts/variables.sh
	-rm -f output/rootfs.tar

clean:
	rm -rf output
