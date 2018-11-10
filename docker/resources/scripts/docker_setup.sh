#!/bin/bash
# Docker Setup - from RAI


echo "$(tput setaf 2)[Updating Packages]...$(tput sgr0)";
sudo apt-get update -qq && apt-get upgrade -y -qq;

echo "$(tput setaf 2)[Adding Curl]...$(tput sgr0)";
sudo apt-get install curl -qq;
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

echo "$(tput setaf 2)[Updating Repositories]...$(tput sgr0)";
sudo apt-get update -qq;

echo "$(tput setaf 2)[Installing Docker Engine]$(tput sgr0)";
sudo apt-get install -y docker-ce -qq;

#echo "DOCKER_OPTS='-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock'" >> /etc/init/docker.conf
service docker restart

# Spacers
echo " " >> ~/.bashrc
echo " " >> ~/.bashrc


# Empire
mkdir /opt/Empire
mkdir /opt/Kali
docker pull empireproject/empire .
docker create -v /opt/Empire --name empire-data empireproject/empire
docker create -v /opt/Kali --name kali-data empireproject/empire
docker run -itd -p 8080-8085:8080-8085 --volumes-from data empireproject/empire --name empire /bin/bash
echo "alias empire='docker attach empire'" >> ~/.bashrc
echo "alias empired='docker run -itd -p 8080-8085:8080-8085 --volumes-from data empireproject/empire empire'" >> ~/.bashrc


# Kali
docker pull kratos/kali:latest
docker run -itd -p 80:80 -p 3000:3000 -p 3001:3001 -v kali-data:/root --name kali kratos/kali:3.0
echo "alias kali='docker attach msf'" >> ~/.bashrc


# Metasploit
docker pull phocean/msf
#docker run --rm -i -t -p 9990-9999:9990-9999 -v /home/$(whoami)/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data --name msf phocean/msf
docker run --rm -it --net=host --hostname msf -v /home/$(whoami)/.msf4:/root/.msf4 -v /tmp/msf:/tmp/data --name msf phocean/msf
echo "alias msf='docket exec -it msf /bin/bash'" >> ~/.bashrc

# ./install_ruby.sh

# Install Pupy RAT
# Install Pupy RAT
# RUN cd /root/tools/post/pupy-rat-multi
# RUN chmod -R +x setup.sh
# RUN ./setup.sh