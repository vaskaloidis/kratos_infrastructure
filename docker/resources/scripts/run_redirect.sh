#!/bin/bash
# run_redirect - Run Redirect Docker
cd ../cyclops
docker run -p 104.216.111.79:80:80 kratos/redirect:1.0 
