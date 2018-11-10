#!/bin/bash
# pull_nmap.sh - Pulls down new NMAP Scans

mkdir /usr/share/nmap/scripts/vulners
git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/vulners

mkdir /usr/share/nmap/scripts/vulscan
git clone https://github.com/scipag/vulscan.git /usr/share/nmap/scripts/vulscan
cd /usr/share/nmap/scripts/vulscan/utilities/updater/
chmod +x updateFiles.sh
./updateFiles.sh