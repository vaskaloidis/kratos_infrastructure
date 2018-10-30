#!/bin/bash
# build_kali.sh - Build Kali kali server kali/Dockerfile

cd ../kali
docker build -t "kratos/kali:1.0" .