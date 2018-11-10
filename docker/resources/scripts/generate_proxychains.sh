#!/bin/bash
# generate_proxycahins.sh - Builds a proxychains file

touch ./proxychains.conf
rm ./proxychains.conf
cp ./proxychains_template.template ./proxychains.conf

#echo $(curl "http://pubproxy.com/api/proxy?limit=5format=txt&http=true&country=US&type=https&level=anonymous") >> ./proxychains.conf
#sleep 3s
#
#echo "# ELITE" >> ./proxychains.conf
#echo $(curl "http://pubproxy.com/api/proxy?limit=5format=txt&http=true&country=US&type=https&level=elite") >> ./proxychains.conf
#sleep 3s
#
#echo "# SOCKS5" >> ./proxychains.conf
#echo $(curl "http://pubproxy.com/api/proxy?limit=5format=txt&http=true&country=US&type=socks5&level=anonymous") >> ./proxychains.conf
#sleep 3s
#
#echo "# RUSSIAN HTTPS" >> ./proxychains.conf
#echo $(curl "http://pubproxy.com/api/proxy?limit=5format=txt&http=true&country=RU&not_country=us&type=https&level=anonymous") >> ./proxychains.conf



proxychains4 echo $(curl "http://pubproxy.com/api/proxy?limit=10format=txt&http=true&country=US&type=https") >> ./proxychains.conf