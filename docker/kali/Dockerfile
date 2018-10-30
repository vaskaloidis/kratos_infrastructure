FROM kalilinux/kali-linux-docker:latest

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y openssh-server python git vim tmux tor curl kali-linux-top10 kali-linux-web
RUN apt-get autoclean


COPY scripts/fetch_nmap.sh /root/
RUN /root/fetch_nmap.sh