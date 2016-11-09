#!/bin/bash
set -x 

export TOOLS_DIR=~/mac/src/rk3188/rabian-build/rock-bsp/tools
export CROSS_COMPILE=$TOOLS_DIR/toolchain/bin/arm-eabi-
export J=5
export KERNEL_SRC=`pwd`
export MODULE_DIR=$KERNEL_SRC/modules
export K_BLD_CONFIG=$KERNEL_SRC/.config
export BOOT=$KERNEL_SRC/boot
export INITRD_DIR=~/mac/src/rk3188/rabian-build/rock-bsp/boards/rock_sdcard/initrd
export BOOTIMG_SECOND=/dev/null

# kernel config file to use for build
# original config of aboche's sdcard image
#export KERNEL_DEFCONFIG=config_rk3188_rtl8723bs.org
# mac-l1's config
export KERNEL_DEFCONFIG=config_rk3188_rtl8723bs.mac

# fix boot logo
rm -f logo-720p.bmp
# use imagemagick convert to convert logo bmp file to right size and format
# somehow kernel can not handle 1080p images (probably page boundary issues in kernel)
convert mac-l1-1080p.bmp -resize 1280x720 -alpha Off bmp3:logo-720p.bmp
cp -f logo-720p.bmp drivers/video/logo/logo_android_bmp.bmp

#make distclean
cp -a $KERNEL_DEFCONFIG $KERNEL_SRC/.config
make -C $KERNEL_SRC ARCH=arm oldconfig
make -C $KERNEL_SRC CROSS_COMPILE=$CROSS_COMPILE ARCH=arm -j$J
make -C $KERNEL_SRC CROSS_COMPILE=$CROSS_COMPILE ARCH=arm -j$J kernel.img
rm -rf $MODULE_DIR
mkdir -p $MODULE_DIR
make -C $KERNEL_SRC CROSS_COMPILE=$CROSS_COMPILE ARCH=arm INSTALL_MOD_PATH=$MODULE_DIR modules
make -C $KERNEL_SRC CROSS_COMPILE=$CROSS_COMPILE ARCH=arm INSTALL_MOD_PATH=$MODULE_DIR modules_install
make -C $KERNEL_SRC CROSS_COMPILE=$CROSS_COMPILE ARCH=arm INSTALL_MOD_PATH=$MODULE_DIR firmware_install

#rm -rf $BOOT
#mkdir -p $BOOT
#cp -vf $KERNEL_SRC/arch/arm/boot/zImage $BOOT
#cp -vf $KERNEL_SRC/.config $BOOT/config
#cp -vf $KERNEL_SRC/System.map $BOOT
#cp -vf $INITRD_DIR/../initrd.img $BOOT
#cd $BOOT && $TOOLS_DIR/bin/mkbootimg --kernel zImage --ramdisk initrd.img --second $BOOTIMG_SECOND -o boot-linux.img && cd - > /dev/null

