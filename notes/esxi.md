# VMWare ESXi

## Reset ESXi Evaluation License

```esxcli
rm -r /etc/vmware/license.cfg
cp /etc/vmware/.#license.cfg /etc/vmware/license.cfg
/etc/init.d/vpxa restart
```

## Reset ESXi Evalution License reset script

```esxclli
#! /bin/sh
## remove license
echo 'Removing License'
rm -r /etc/vmware/license.cfg
## get a new license
echo 'Copying License'
cp /etc/vmware/.#license.cfg /etc/vmware/license.cfg
## restart services
echo 'Restarting VPXA'
/etc/init.d/vpxa restart
```

## Update ESXi from command line

- open http/https in firewall: `esxcli network firewall ruleset set -e true -r httpClient`
- find version to update/load: `esxcli software sources profile list --depot=https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml | grep -i ESXi-6.7.0-2021`
- load update: `esxcli software profile update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml -p ESXi-6.7.0-20180804001-standard`
- reset http/https firewall rule: `esxcli network firewall ruleset set -e false -r httpClient`

## Working with VM Files

- Copying (`cp` or `scp`) a vmdk flat file will read null pointers (ie full size file)
  - use `vmfstools` to avoid null pointers being replaced with 0s
  - `vmkfstools -i "source.vmdk" -d thin "destination.vmdk"`
