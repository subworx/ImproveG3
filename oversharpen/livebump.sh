#!/sbin/sh
#Livebump for LG G3 kernel
#by skin1980@xda

IMAGE=/tmp/original-boot.img

if [ -z $IMAGE ]; then exit 1; fi
mkdir /tmp/out
/tmp/unpackbootimg -i $IMAGE -o /tmp/out

if [ -e /tmp/out/original-boot.img-ramdisk.gz ]; then
	rdcomp=/tmp/out/original-boot.img-ramdisk.gz
elif [ -e /tmp/out/original-boot.img-ramdisk.lz4 ]; then
	rdcomp=/tmp/out/original-boot.img-ramdisk.lz4
else
	exit 1
fi

/tmp/mkbootimg --kernel /tmp/out/original-boot.img-zImage --ramdisk $rdcomp --dt /tmp/out/original-boot.img-dt --cmdline "$(cat /tmp/out/original-boot.img-cmdline)" --pagesize $(cat /tmp/out/original-boot.img-pagesize) --base $(cat /tmp/out/original-boot.img-base) --ramdisk_offset $(cat /tmp/out/original-boot.img-ramdisk_offset) --tags_offset $(cat /tmp/out/original-boot.img-tags_offset) --output /tmp/image_bumped.img


echo "Bumping the boot.img..."
printf '\x41\xA9\xE4\x67\x74\x4D\x1D\x1B\xA4\x29\xF2\xEC\xEA\x65\x52\x79' >> /tmp/image_bumped.img

