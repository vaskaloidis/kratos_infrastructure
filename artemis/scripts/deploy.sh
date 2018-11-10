#!/bin/bash
# setup.sh

set -o nounset

if [ ! -z ${1} ];
then
 touch /etc/docker/daemon.json
 echo "{" >> /etc/docker/daemon.json
 echo "'hosts': ['unix:///var/run/docker.sock', 'tcp://$1:2375']" >> /etc/docker/daemon.json
 echo "}" >> /etc/docker/daemon.json
fi

# Install Docker
chmod +x resources/scripts/*.sh

sh resources/scripts/docker_setup.sh
echo "DOCKER_OPTS='-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock'" >> /etc/init/docker.conf
service docker restart

mkdir /opt/Empire
mkdir /opt/Kali
docker pull empireproject/empire .
docker create -v /opt/Empire --name empire-data empireproject/empire
docker create -v /opt/Kali --name kali-data empireproject/empire

# resources/scripts/build_kali.sh
cd /root/kali/
docker build -t "kratos/kali:3.0" .
#docker pull "kratos/kali:3.0" # TODO: Finish deploying kratos/kali:3.0 to Docker Hub

# Empire
docker run -itd -p 8080-8085:8080-8085 --volumes-from data empireproject/empire --name empire /bin/bash

# Metasploit
#docker run --rm -i -t -p 9990-9999:9990-9999 -v /home/$(whoami)/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data --name msf phocean/msf
docker run --rm -it --net=host --hostname msf -v /home/$(whoami)/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data --name msf phocean/msf

# Kali
#docker run -itd -p 80:80 -p 3000:3000 -p 3001:3001 -v kali-data:/root --name kali kratos/kali:3.0

# ./install_ruby.sh

# Install Pupy RAT
# Install Pupy RAT
# RUN cd /root/tools/post/pupy-rat-multi
# RUN chmod -R +x setup.sh
# RUN ./setup.sh


echo " " >> ~/.bashrc
echo " " >> ~/.bashrc
echo "alias msf='docket exec -it msf /bin/bash'" >> ~/.bashrc
echo "alias kali='docker attach msf'" >> ~/.bashrc
echo "alias empire='docker attach empire'" >> ~/.bashrc
echo "alias empired='docker run -itd -p 8080-8085:8080-8085 --volumes-from data empireproject/empire empire'" >> ~/.bashrc