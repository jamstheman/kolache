kolache
=======
applications needed on router for dns exfil:
dig
xxd


https://hackucf.org/blog/hack-all-the-things-exfiltrating-data-via-dns-requests/


http://jontai.me/blog/2011/11/monitoring-dns-queries-with-tcpdump/


1.) External drive should be encrypted. 
http://oneitguy.com/blog/encrypted-remote-backup-openwrt
https://dev.openwrt.org/ticket/10787
http://gui-at.blogspot.com/2010/02/disk-encryption-in-openwrt.html
http://sjoosten.nl/2013/06/luks-usb-stick.html

2.) Once the SD card is mounted. Run a script that changes the device host name and mac address to something like an apple iphone/ipad or samsung android device. 

3.) Once mounted, ethernet in and set up the device for monitoring in X minutes

4.) Scans. Finds unencrypted wifi or WEP and cracks it.
  
5.) Once on the target network, does an arp scan and then nmap of hosts.

6.) Finds way to internet

7.) Exfil data. All data should be encrypted with openssl before exfiltration.
tar -P -zcf - $dirname | openssl aes-128-cbc -out $dirname.tar.gz -k 1234

(tar/gzip everything in a given directory. AES-128 encrpt file. set the password to the file as "1234")


8.) Opens reverse ssh into network. 

9.) Win...
