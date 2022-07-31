# Proxmox - cloud init image  

### Create a cloud init image  

```bash
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
qm create 8000 --memory 2048 --core 2 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
qm importdisk 8000 focal-server-cloudimg-amd64.img local-lvm
qm set 8000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-8000-disk-0
qm set 8000 --ide2 local-lvm:cloudinit
qm set 8000 --boot c --bootdisk scsi0
qm template 8000
qm clone 8000 135 --name yoshi --full
```

---

### Additional example with bash loop for actions

**Add the SSH Key and Serial for the console connection**

```bash
qm create 901 --name focal-cloud --memory 8192 --sockets 1 --cores 4 --net0 virtio,bridge=vmbr1 
qm set 901 --agent enabled=1 
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img 
qm importdisk 901 focal-server-cloudimg-amd64.img data-thin 
rm ./focal-server-cloudimg-amd64.img 
qm set 901 --scsihw virtio-scsi-pci --scsi0 data-thin:vm-901-disk-0 
qm set 901 --boot c --bootdisk scsi0 
qm set 901 --ide2 data-thin:cloudinit 
qm set 901 --sshkey ./id_rsa.pub
qm set 901 --serial0 socket --vga serial0
qm template 901 
qm clone 901 200 --full --name rancher1 
qm clone 901 201 --full --name rke1 
qm clone 901 202 --full --name rke2 
qm clone 901 203 --full --name rke3 
qm set 200 --ipconfig0 ip=10.10.10.240/24,gw=10.10.10.1 
qm set 201 --ipconfig0 ip=10.10.10.241/24,gw=10.10.10.1 
qm set 202 --ipconfig0 ip=10.10.10.242/24,gw=10.10.10.1 
qm set 203 --ipconfig0 ip=10.10.10.243/24,gw=10.10.10.1 
for i in {200..203}; do qm resize $i scsi0 100G; done 
for i in {200..203}; do qm set $i --onboot=1; done 
for i in {200..203}; do qm start $i; done
```
