#!/bin/bash
# build_redirector.sh - Build Docker HTTP Redirector Cyclops/Dockerfile

cd ../redirect
docker build --build-arg TEAM_SERVER="http://C2:c2_port" --build-arg LPORT=80 -t kratos/cyclops:1.0 .  