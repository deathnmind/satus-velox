Secure Splunk Web with your own certificate
If you have already generated certificates and signed them yourself, or purchased third party certificates, you can secure Splunk Web with your own certificate using the procedures in this topic. If you have not yet generated or purchased certificates, see the following topics to learn how to obtain the certificates:

Self-sign certificates for Splunk Web.
Get a certificates signed by a third-party for Splunk Web.
Prerequisites
You can only configure Splunk Web to use certificates and keys using configuration files if you have access to the file system, such as if you are a system administrator. If you don't have this access, obtain it first.
Review the steps in How to edit a configuration file in the Splunk Enterprise Admin Manual to learn how to edit configuration files.
Before you secure Splunk Web with a certificate, confirm that the certificates and keys are available. The certificate file must be in privacy-enhanced mail (PEM) format. The following example uses $SPLUNK_HOME/etc/auth/mycerts/ as the directory where the key and certificate are located:
```
$SPLUNK_HOME/etc/auth/mycerts/mySplunkWebCertificate.pem
$SPLUNK_HOME/etc/auth/mycerts/mySplunkWebPrivateKey.key
```

Configure Splunk Web to use the key and certificate files
Perform the following steps to configure Splunk Web to use the key and certificate files.

Never change or copy the configuration files in the $SPLUNK_HOME/etc/default directory. The files in the default directory must remain intact and in their original location. Make changes to the files in the $SPLUNK_HOME/etc/system/local directory.

Open or create a local web.conf configuration file for the Search app in $SPLUNK_HOME/etc/system/local. If you use a deployment server, you can create this file in any application directory that you make available to the deployment server for download to deployment clients.
Under the [settings] stanza, configure the path to the file that contains the web server SSL certificate private key file and the path to the Splunk web server certificate file.
You may use absolute paths when you configure these settings by prepending a / to the path. Non-absolute paths are relative to the Splunk installation directory ($SPLUNK_HOME). If you use a non-absolute path, do not add $SPLUNK_HOME to the path

The following example shows an edited settings stanza:
```conf
[settings]
enableSplunkWebSSL = true
privKeyPath = /opt/splunk/etc/auth/mycerts/mySplunkWebPrivateKey.key 
serverCert = /opt/splunk/etc/auth/mycerts/mySplunkWebCertificate.pem 
```
Save the file and close it.
Restart the Splunk Enterprise instance:
```bash
# $SPLUNK_HOME/bin/splunk restart splunkd
```