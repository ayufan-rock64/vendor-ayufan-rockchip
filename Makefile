all: idbloader.img

idbloader.img: DDRTEMP u-boot-mainline/tools/mkimage
	u-boot-mainline/tools/mkimage -n rk3328 -T rksd -d $< $@.tmp
	cat u-boot-android/tools/rk_tools/bin/rk33/rk322xh_miniloader_v2.44.bin >> $@.tmp
	mv $@.tmp $@

u-boot-mainline:
	git clone https://github.com/ayufan-rock64/linux-u-boot --single-branch --depth=1 $@

u-boot-android:
	git clone https://github.com/ayufan-rock64/android-u-boot --single-branch --depth=1 $@

u-boot-mainline/tools/mkimage: u-boot-mainline
	make -C $< rock64-rk3328_defconfig tools CROSS_COMPILE="ccache aarch64-linux-gnu-"

DDRTEMP: u-boot-android
	dd if=u-boot-android/tools/rk_tools/bin/rk33/rk3328_ddr_333MHz_v1.08.bin of=DDRTEMP bs=4 skip=1

clean:
	rm -rf u-boot-mainline u-boot-android
