#!/sbin/sh
#Livebump for kitkat stock kernel
#by skin1980@xda

IMAGE=/tmp/original-boot.img
size=`stat -c %s $IMAGE`

size=$(($size-1))
lastchar=`dd if=$IMAGE skip=$size count=1 bs=1 2>/dev/null | od |sed -n 1p | cut -c 13-`
newsize=$(($size+1))

while [ $lastchar == 00 ]; 
do
		newsize=$(($newsize-2048))
		lastchar=`dd if=$IMAGE skip=$newsize count=1 bs=1 2>/dev/null | od |sed -n 1p | cut -c 13-`

done

bumpsize=$newsize


dd if=$IMAGE of=/tmp/newbump.img count=1 bs=$newsize
cat /tmp/newbump.img /tmp/firma > /tmp/image_bumped.img

