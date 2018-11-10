#!/bin/bash


ssh -o ProxyCommand="nc -x localhost:9050 104.216.111.79 22" root@104.216.111.79

#scp -o ProxyCommand="nc -x localhost:9050 104.216.111.79 22" /Users/vasilioskaloidis/deploy.tar.gz root@104.216.111.79:/tmp
#scp -o ProxyCommand="nc -x localhost:9050 Zeus 22" /Users/vasilioskaloidis/deploy.tar.gz root@104.216.111.79:/tmp

# ProxyCommand socat STDIO SOCKS4A:localhost:104.216.111.79:22,socksport=9050