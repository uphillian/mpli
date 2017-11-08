#!/usr/bin/python
# Modified version of script from @rochacbruno

"""
Save this file as server.py
>>> python server.py 0.0.0.0 8001
serving on 0.0.0.0:8001

or simply

>>> python server.py
Serving on localhost:8000

You can use this to test GET and POST methods.

"""

import SimpleHTTPServer
import SocketServer
import logging
import yaml

import sys


if len(sys.argv) > 2:
    PORT = int(sys.argv[2])
    I = sys.argv[1]
elif len(sys.argv) > 1:
    PORT = int(sys.argv[1])
    I = ""
else:
    PORT = 8000
    I = ""

def construct_ruby_object(loader, suffix, node):
  return loader.construct_yaml_map(node)

def construct_ruby_sym(loader, node):
  return loader.construct_yaml_str(node)

yaml.add_multi_constructor(u"!ruby/object:", construct_ruby_object)
yaml.add_constructor(u"!ruby/sym", construct_ruby_sym)

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):

    def do_POST(self):
        length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(length)
        y=yaml.load(post_data)
        print("Receiving report for %s" % y['host'])
        print("Saving to /tmp/%s.yaml" % y['configuration_version'])
        f = open('/tmp/%s.yaml' % y['configuration_version'],'a')
        f.write(post_data)
        f.close()

Handler = ServerHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "Listening at http://%(interface)s:%(port)s" % dict(interface=I or "localhost", port=PORT)
httpd.serve_forever()
