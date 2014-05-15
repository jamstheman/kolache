import SocketServer
import SimpleHTTPServer
import urllib, urllib2
import re
import os

PORT = 1234

class Proxy(SimpleHTTPServer.SimpleHTTPRequestHandler):
    error_message_format = ""
    def send_error(self, code, message):
        return
    def do_GET(self):
        if self.path[len(self.path)-3:] == "exe":
                self.path="/test.txt"
        else:
                urlhandle = urllib.urlopen(self.path)
                self.wfile.write(urlhandle.read())
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)


httpd = SocketServer.ForkingTCPServer(('', PORT), Proxy)
print "serving at port", PORT
httpd.serve_forever()
