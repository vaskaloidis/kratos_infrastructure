#!/bin/bash

#docker run -d --net host --restart always --name tor jess/tor
docker run -d --restart always -v /etc/localtime:/etc/localtime:ro -p 9050:9050 --name torproxy jess/tor-proxy

regular_ip = $(curl -L http://ifconfig.me)
proxy_ip = $(curl --socks http://localhost:9050  -L http://ifconfig.me)
tor_project_api = $(curl --socks http://localhost:9050  -L https://check.torproject.org/api/ip)

echo "REGULAR IP: $regular_ip"
echo "PROXY IP: $proxy_ip"
echo "TOR Project API IP: $tor_project_api"

if [ regular_ip -eq proxy_ip ]; then
    echo 'SECURITY CHECK 1/3 - PASS'
elif [regular_ip -ne proxy_ip]; then
    echo 'IP Was not changed. Exiting. CONNECTION IS NOT SECURE'
    return 1
fi

docker run -d --restart always -v /etc/localtime:/etc/localtime:ro --link torproxy:torproxy -p 8118:8118 --name privoxy jess/privoxy

regular_ip = $(curl -L http://ifconfig.me)
privoxy_ip = $(curl --socks http://localhost:8118  -L http://ifconfig.me)
privoxy_tor_project_api = $(curl --socks http://localhost:8118  -L https://check.torproject.org/api/ip)

echo "REGULAR IP: $regular_ip"
echo "PROXY IP: $proxy_ip"
echo "TOR Project API IP: $tor_project_api"

if [ regular_ip -eq privoxy_ip ]; then

    echo 'SECURITY CHECK 3/3 - PASS'

    if [ regular_ip -eq privoxy_tor_project_api ]; then
        echo 'SECURITY CHECK 1/3 PASS'
        ECHO 'CONNECTION-SECURE'
    elif [regular_ip -ne privoxy_tor_project_api]; then
       echo 'IP Was not changed. Exiting. CONNECTION IS NOT SECURE'
    fi

elif [regular_ip -ne privoxy_ip]; then
    echo 'IP Was not changed to Privoxy. Exiting. CONNECTION IS NOT SECURE'
    return 1
fi