#!/bin/env bash
export KERN_DIR=/root/Android/KernelSource/android_kernel_sony_xperia_z1
export DT_BUILDER_DIR=/root/Android/Compiler/dt_tools
export BOOTIMG_BUILDER_DIR=/root/Android/Compiler/bootimg_tools

function build_dt_img() {
	cd $DT_BUILDER_DIR
	if [[ -f dt.img ]]; then
		rm dt.img
		echo "Removing previous dt.img..."
	fi
	echo "Builing dt.img"
	./dtbTool -o dt.img -s 2048 -p $KERN_DIR/scripts/dtc/ $KERN_DIR/arch/arm/boot/
	echo "Copying dt.img"
	cp dt.img $BOOTIMG_BUILDER_DIR
}

function build_kernel_img() {
	cd $BOOTIMG_BUILDER_DIR
	if [[ -f zImage ]]; then
		echo "Removing previous zImage..."
		rm zImage		
	fi
	if [[ -f boot.img ]]; then
		echo "Removing previous boot.img..."
		rm boot.img
	fi
	echo "Copying zImage..."
	cp $KERN_DIR/arch/arm/boot/zImage $BOOTIMG_BUILDER_DIR
	echo "Builing boot.img"
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

if [[ -f $KERN_DIR/arch/arm/boot/zImage ]]; then
	build_dt_img
	build_kernel_img
	if [[ -f $BOOTIMG_BUILDER_DIR/boot.img ]]; then
		echo "boot.img successfuly built"
		exit 0
	fi
else
	echo "zImage is not found!!!"
	sleep 2
	exit 1
fi