#!/bin/bash
# kratos_send.sh - Send over SCP with Kratos


mkdir ~/deploy_tmp
cp -R ~/kratos/docker/ ~/deploy_tmp


sudo chown -R root ~/deploy_tmp
tar -zcvf ~/deploy.tar.gz ~/deploy_tmp