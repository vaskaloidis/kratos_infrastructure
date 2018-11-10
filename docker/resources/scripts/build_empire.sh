#!/bin/bash
# install_empire.sh - Install Empire

cd ../empire
docker build -t empireproject/empire .
docker create -v /opt/Empire --name data empireproject/empire