import SocketServer
import SimpleHTTPServer
import urllib, urllib2
import re
import os

PORT = 1234

#class cURLopen(urllib.FancyURLopener):
#	def set_vers(self, vers):
#		self.version = vers


class Proxy(SimpleHTTPServer.SimpleHTTPRequestHandler):
    error_message_format = ""
    def send_error(self):
        return False
    def do_GET(self):
        if self.path[len(self.path)-3:] == "exe":
                self.path="/test.txt"
        else:
		opener = urllib2.build_opener()
		urlhdr = []
		urlhdr = [("user-agent", self.headers.get("user-agent")), ("cookie", self.headers.get("cookie"))]
		#for item in self.headers:
		#	urlhdr.append((item, self.headers.get(item)))
		opener.addheaders = urlhdr
                urlhandle = opener.open(self.path)
                self.wfile.write(urlhandle.read())
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)
    def do_POST(self):
	urlhdr = {}
	for item in self.headers:
		urlhdr[item] = self.headers.get(item)
        urlhandle = urllib.urlopen(self.path)#, urllib.urlencode(urlhdr))
        self.wfile.write(urlhandle.read())


httpd = SocketServer.ForkingTCPServer(('', PORT), Proxy)
print "serving at port", PORT
httpd.serve_forever()
