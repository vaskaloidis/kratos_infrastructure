#!/bin/bash
# run_redirect.sh

docker run -itd -p 8080-8085:8080-8085 --volumes-from data empireproject/empire --name empire /bin/bash
# docker run -ti --volumes-from data empireproject/empire
# docker run -ti --volumes-from data -p 70.x.x.x:80:80 empireproject/empire
# docker run -ti --entrypoint bash empireproject/empire
