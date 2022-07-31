# How to use Multipass to quickly make Ubuntu Server Volatility profiles

Why multipass?  Its quicker to start and stop a multipass instance when changing the kernel compared to a VM or physical computer, or why not?

1. Install Multipass  
`snap install multipass`
1. Create the Ubuntu server for the major version  
`multipass launch focal --name server1`
1. Launch a shell in the multipass instance  
`multipass shell server1`
1. Install all the required Volatility dependencies

```bash
sudo apt update
sudo apt install make binutils dwarfdump build-essential gcc linux-headers-generic libdwarf-dev -y
git clone https://github.com/volatilityfoundation/volatility.git
```

5. determine the current running linux kernel - multipass should always run the latest release  
`uname -r`
1. install the desired kernel if it is an older one than current  
`sudo apt install linux-headers-5.11.0-34-generic linux-image-5.11.0-34-generic`
1. this kernel will be installed in `/boot` but won't be running  
    - You change change the running kernel until is has been loaded during boot
    - Multipass won't let you choose the kernel to boot interactively
    - edit the grub configuration to boot from the older kernel
1. edit `/etc/default/grub` -- this file tells grub which menu item to select  
    - by default the `GRUB_DEFAULT="0"` boots the first menu item
    - the added older kernerl will by the last added menu option
    - should be the 4th item
    - force Grub to default to the new menu item  
    - Change `/etc/default/grub` file with the line `GRUB_DEFAULT="0"` to `GRUB_DEFAULT="1>4"`
1. Update grub configuration  
`sudo update-grub`
1. Restart multipass instance  
`sudo reboot`
1. Once out of multipass start the instance  
`mutlipass start server1`
1. Enter into the multipass instance shell  
`multipass shell server1`
1. Verify the older kernel is loaded  
`uname -r`
1. Change to volatility git clone to run the make command and create a module.dwarf for older kernel  
`cd ~/volatility/tools/linux`  
`make`
1. If this doesn't succeed read the errors and ensure no kernel packages or make utilities are missing `make clean` will clean the `make` process and allow it to startover
1. Once the `module.dwarf` is created, move out the files needed for a volatility profile
    - `module.dwarf` and the `System.map-5.11.0-34-generic` is needed for the Volatility profile
    - the profile must be zipped into one file with the `module.dwarf` in the root and `System.map-5.11.0-27-generic` in a `/boot` directory in the zip
17. Volatility linux profiles go in `/usr/local/lib/python2.7/dist-packages/volatility/plugins/overlays/linux/`
18. In some cases the make seems to fail due to pathing.  In the `Makefile` change all instances of `$(PWD)` to `$(shell pwd)`
