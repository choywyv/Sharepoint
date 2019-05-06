Quick and dirty way to test connection to Sharepoint using Java with self signed certificate


**Steps to create self signed certificate**

set the correct path
set OPENSSL_CONF=c:\openssl\bin\openssl.cnf

generate certificate and key files 
openssl req -new -newkey rsa:2048 -x509 -days 30 -nodes -out certname.cer -keyout certname.key

using the key file previously, export out as pfx, will prompt for password
openssl pkcs12 -export -out certname.pfx -inkey certname.key -in certname.cer -name myalias
