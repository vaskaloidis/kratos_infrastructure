#!/bin/bash
# recon.sh [IP] [OUTPUT-FILE].xml -  NMAP Scans an IP and exports the results

set -o nounset


if [ ! -z ${2} ];
then
    if [ ! -z ${1} ];
    then
        mkdir -p /root/nmap-output/bustedmugshots/
        cd /root/nmap-output/bustedmugshots/
        nmap --script nmap-vulners -oX $2 -sV $1-vulners.xml
        nmap --script vulscan -oX $2 -sV $1-vulscan.xml

    fi
fi