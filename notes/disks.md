# Disks and Logical Volumes

**Show disks by ID / LABEL / PATH / UUID**

```bash
ls -la /dev/disk/by-id /dev/disk/by-label /dev/disk/by-path /dev/disk/by-uuid
blkid
lsblk
```

**LVM Create and mount**  

#### edit fstab and add /dev/mapper/lvm_opt-opt /opt xfs defaults 0 0

```bash
pvcreate /dev/sdb
pvdisplay
vgcreate lvm_opt /dev/sdb
vgdisplay
lvcreate --name opt -l 100%FREE lvm_opt
lvdisplay
mkfs.xfs /dev/lvm_opt /opt
mount /dev/opt_lvm/opt /opt
```

**Multiple Drive with LVM**  

```bash
pvcreate /dev/sda2 /dev/sdb1
vgcreate VG_DATA /dev/sda2 /dev/sdb1
lvcreate -l 100%FREE -n DATA VG_DATA
mkfs.ext3 /dev/VG_DATA/DATA
mount /dev/VG_DATA/DATA /data
```
