#!/bin/env bash

function exportall() {
	export CROSS_COMPILE=/root/Android/Compiler/arm-cortex_a15-linux-gnueabihf-linaro_4.9.2-2014.08/bin/arm-cortex_a15-linux-gnueabihf-
	export ARCH="arm"
	export CT_ARCH_ARCH=""
	export CT_ARCH_CPU="cortex-a15"
	export CT_ARCH_TUNE="cortex-a15"
	export CT_ARCH_FPU="neon-vfpv4"
	export CT_ARCH_FLOAT_HW=y
	export CT_ARCH_FLOAT="hard"
	export CT_ARCH_SUPPORT_SOFTFP=y
	export CT_ARCH_ARM_MODE="arm"
	export CT_ARCH_ARM_MODE_ARM=y
}

function distclean() {
	exportall
	echo "Cleaning..."
	make distclean
	echo "Done"
}

function import() {
	exportall
	echo "Importing SuperMassive BlackHole defconfig"
	make supermassive_blackhole_defconfig
	echo "Done"
}

function build() {
	exportall
	echo "Builing zImage"
	make -j8
	if [[ -f arch/arm/boot/zImage ]]; then
		echo "zImage successfuly built"
		exit 0
	else
		echo "Something wrong when compiling, check log for more information!"
		exit 1
	fi
}

case $1 in
	-d|--distclean)
		distclean
		;;
	-i|--import)
		import
		;;
	-b|--build)
		build
		;;
	-a|--all)
		distclean
		import
		build
		;;
	*)
		echo "Usage: $0 {-d|-i|-b|-a}"
		echo "-d | --distclean 	: Execute make distclean"
		echo "-i | --import 		: Execute make supermassive_blackhole_defconfig"
		echo "-b | --build 		: Execute make -j8"
		echo "-a | --all 		: Execte make distclean; make supermassive_blackhole_defconfig; make -j8"
esac