FROM kalilinux/kali-linux-docker:latest

# SHELL ["/bin/bash"]

RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

RUN apt-get install -y python git vim tmux tor curl kali-linux-top10 kali-linux-web \
 exploitdb \
 exploitdb-bin-sploits \
 git \
 gdb \
 gobuster \
 hashcat \
 hydra \
 man-db \
 minicom \
 nasm \
 nmap \
 sqlmap \
 sslscan \
 wordlists
 # RUN apt-get autoclean


#RUN touch /root/.ssh/known_hosts
#RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
#RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
#RUN git clone https://github.com/danielmiessler/SecLists.git /opt/seclists # TODO: Install this
#RUN git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit
#RUN pip install pwntools
#ENV PATH=$PATH:/opt/powersploit

COPY resources/proxy-servers /root/
COPY resources/tor_transparent_proxy.sh /root/
COPY database.xml /root/
COPY msf4 /root/.msf4
COPY resources/tools /root/

RUN chmod -R +x /root/

# RUN /root/tor_transparent_proxy.sh

# Nmap Scripts
RUN mkdir /usr/share/nmap/scripts/vulners
RUN git clone https://github.com/vulnersCom/nmap-vulners.git /usr/share/nmap/scripts/vulners
RUN mkdir /usr/share/nmap/scripts/vulscan
RUN git clone https://github.com/scipag/vulscan.git /usr/share/nmap/scripts/vulscan
RUN cd /usr/share/nmap/scripts/vulscan/utilities/updater/
#RUN chmod +x updateFiles.sh
#RUN ./updateFiles.sh #TODO: Update

# Set entrypoint and working directory
WORKDIR /root/

# Indicate we want to expose ports 80 and 443
EXPOSE 80/tcp 443/tcp