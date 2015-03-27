#!/bin/sh
vagrant ssh -c 'chromium-browser --incognito --proxy-server=socks5://localhost:9050 http://check.torproject.org --enable-plugins'
