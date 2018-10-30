#!/bin/bash
# kali proxychainned commands

# Check if running
docker run -d --name tor kali sh -c "tor"
# Pause after starting (10 seconds to startup ish)