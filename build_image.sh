#!/bin/env bash
export CROSS_COMPILE=/root/Android/Compiler/android_prebuilt_toolchains/arm-eabi-linaro-4.6.2/bin/arm-eabi-
export ARCH=arm
export KERN_DIR=/root/Android/KernelSource/android_kernel_sony_xperia_z1
export DT_BUILDER_DIR=/root/Android/Compiler/dt_tools
export BOOTIMG_BUILDER_DIR=/root/Android/Compiler/bootimg_tools

function make_all() {
	echo "Cleaning up..."
	sleep 3
	make distclean
	echo "Importing supermassive_blackhole_defconfig..."
	sleep 2
	make supermassive_blackhole_defconfig
	echo "Builing........"
	sleep 3
	make -j5
}

function build_dt_img() {
	echo "Builing dt.img"
	cd $DT_BUILDER_DIR
	rm dt.img
	./dtbTool -o dt.img -s 2048 -p $KERN_DIR/scripts/dtc/ $KERN_DIR/arch/arm/boot/
	cp dt.img $BOOTIMG_BUILDER_DIR
}

function build_kernel_img() {
	echo "Builing boot.img"
	cd $BOOTIMG_BUILDER_DIR
	rm zImage
	rm boot.img
	cp $KERN_DIR/arch/arm/boot/zImage $BOOTIMG_BUILDER_DIR
	./mkbootimg --base 0x00000000 \
	--kernel zImage \
	--ramdisk_offset 0x02000000 \
	--tags_offset 0x01E00000 \
	--pagesize 2048 \
	--cmdline "androidboot.hardware=qcom user_debug=31 maxcpus=2 msm_rtb.filter=0x3F ehci-hcd.park=3 msm_rtb.enable=0 lpj=192598 dwc3.maximum_speed=high dwc3_msm.prop_chg_detect=Y" \
	--ramdisk ramdisk.cpio.gz \
	--dt dt.img \
	-o boot.img
}

make_all
build_dt_img
build_kernel_img