#!/bin/bash
# run_kali.sh - Build Docker Kali Poseidon

cd ../kali

# Production
# docker run -p 104.216.111.79:80:80 kratos/kali:1.0 
# docker run -itd -p 80:80 -p 3000:3000 -p 3001:3001 -v kali:/root -v metasploit:/usr/share/metasploit-framework --name kali kratos/kali:2.0

# Development
docker create -v /opt/metasploit-framework/embedded/framework/scripts --name kali-scripts kratos/kali:1.0
docker run -itd -p 8080:8080 -p 3000:3000 -p 3001:3001 -v kali:/root -v metasploit:/usr/share/metasploit-framework -v kali-scripts:/usr/share/metasploit-framework/scripts --name kali kratos/kali:1.0
