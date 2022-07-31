# Disk Images

**commands to mount raw disk images - -r option is readonly -- maps to /dev/mapper**</br>
`kpartx -a -v -r ./ image.raw`

**noload required with Read-Only**</br>
`mount -o ro,noload /dev/mapper/loop /mnt/point`  

**using losetup - included in base Ubuntu**  
`losetup -l` **list all loop devices**  
`losetup -f -r -P raw_disk_image` **-r is read-only -- -P is not open partition**  
`fdisk -l /dev/loop_created_previous_step`  
