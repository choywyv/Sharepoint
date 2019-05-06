#Quick and dirty way to test connection to Sharepoint using Java with self signed certificate


**Steps to create self signed certificate**
1. Download the openssl program and set the correct path in the command prompt for the openssl.cnf. For some reason and in this era, openssl is still so stupid that it needs to have the path defined specifically as it doesn't have a default like %installed_directory% or else it keeps showing errors finding the config file.
set OPENSSL_CONF=c:\openssl\bin\openssl.cnf

2. Generate certificate and key files
openssl req -new -newkey rsa:2048 -x509 -days 30 -nodes -out certname.cer -keyout certname.key

3. using the key file previously, export out as pfx, will prompt for password
openssl pkcs12 -export -out certname.pfx -inkey certname.key -in certname.cer -name myalias
