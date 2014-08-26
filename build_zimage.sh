#!/bin/env bash

export CROSS_COMPILE=/root/Android/Compiler/android_prebuilt_toolchains/arm-cortex_a15-linux-gnueabihf-linaro_4.9.1/bin/arm-cortex_a15-linux-gnueabihf-
export ARCH=arm

echo "Cleaning..."
make distclean
echo "Importing SuperMassive BlackHole defconfig"
make supermassive_blackhole_defconfig
echo "Builing zImage"
make -j8
if [[ -f arch/arm/boot/zImage ]]; then
	echo "zImage successfuly built"
	exit 0
else
	echo "Something wrong when compiling, check log for more information!"
	exit 1
fi