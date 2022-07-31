## Disable Resolved on Ubuntu

**Background** Ubuntu runs its own resolver DNS service, which can interfere with other programs that listen on default DNS ports.  This has to be stopped and disabled for these programs to work. This service is called `systemd-resolved`.  

**Stop and disable the service**

```bash
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
```  

**Remove the symbolic link from `/etc/resolv.conf` to `/run/systemd/resolve/stub-resolve.conf`**

```bash
sudo rm /etc/resolv.conf
```  

**Create a new `/etc/resolv.conf` with correct dns information**

```bash
sudo nano /etc/resolv.conf
```

add DNS resolvers and search domain

```bash
search example.local
nameserver 192.168.0.1
nameserver 9.9.9.9
```
