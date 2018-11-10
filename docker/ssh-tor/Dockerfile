# image base
FROM ubuntu:16.04

LABEL description="Tor SSH Container."

# set the def shell for ENV
SHELL ["/bin/bash", "-c"]

# install basic build items
RUN apt-get update && apt-get install -y ssh proxychains

COPY redirect.sh /root/
RUN chmod +x /root/redirect.sh
#RUN /root/redirect.sh