#!/bin/bash
# package.sh - Package files to send over SCP


cp -R ~/kratos ~/deploy
sudo chown -r root ~/deploy
tar -zcvf ~/deploy.tar.gz ~/deploy
