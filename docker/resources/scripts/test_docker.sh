#!/bin/bash
# test_docker.sh

docker run -t -i kalilinux/kali cat /etc/debian_version &&\ echo "Build OK" || echo "Build failed!"