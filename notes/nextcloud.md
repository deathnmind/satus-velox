# Nextcloud #
All of the commands below work with the Snap, Docker, or base installed version of Nextcloud.  
## Snap
The Snap commands are ran as `nextcloud.occ` 
## Docker
If using the Docker of Nextcloud open an interactive command line into the container as the user running Nextcloud:  
`docker exec -it -u 33 nextcloud /bin/bash`  
Once inside the container run the `occ` command from `/var/www/html/occ`

## Base installation
Use php to run the `occ` commands and use `sudo` to run them as the service running Nextcloud.  
`sudo -u apache /opt/rh/php70/root/usr/bin/php /var/www/html/nextcloud/occ`

----
## Snap Commands ##

**Reset a user's password**  
`sudo nextcloud.occ user:resetpassword admin`  

**Enable HTTPS with self-signed certificate**  
`sudo nextcloud.enable-https self-signed`

**Changed default files to empty directory**  
`sudo nextcloud.occ config:system:set skeletondirectory --value=""`

**Clear LDAP configuration**  
`sudo nextcloud.occ ldap:delete-config s01`

**Get LDAP Configuration**  
`sudo nextcloud.occ ldap:show-config`  

----

## Self-signed certificates and Nextcloud Snap

Nextcloud snap expects the certificates to be in PEM format.  Most of the time certificates are created in the PEM format and renaming the file extension from .crt to .pem will suffice. Sometimes the certificates my be in DER format and conversion is required:  
`openssl x509 -inform DER -in yourdownloaded.crt -out outcert.pem -text`

To enable SSL on Nextcloud the public, private, and full-chain (usually just the CA.crt) are required Copy the respective certificates into the snap's location (the SNAP will have a different number):

```bash
sudo cp nextcloud.public.crt /var/snap/nextcloud/30258/certs/live/cert.pem
sudo cp nextcloud.private.key /var/snap/nextcloud/30258/certs/live/privkey.pem
sudo cp ca.crt /var/snap/nextcloud/30258/certs/live/chain.pem
```

Once the required certificates are in the correct location run the Nextcloud enable SSL command, the command must read the certificates in and verify against the certificates expected in the snap location.

Enable HTTPS with custom certificates (must be PEM format)  
`sudo nextcloud.enable-https custom nextcloud.public.pem nextcloud.private.pem ca.pem`

----

## Trusted Domains
After setting Nextcloud to HTTPS and the DNS resolution to a hostname be sure to add the host name to the trusted domains.

Get the current list of trusted domains:   
`sudo nextcloud.occ config:system:get trusted_domains`  
This should return 1 item (the host nextcloud was installed as) and the list starts at 0.  To add to the list use value 1:  
`sudo nextcloud.occ config:system:set trusted_domains 1 --value=nextcloud.internal`  
