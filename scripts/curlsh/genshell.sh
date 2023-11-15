#!/bin/bash
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout curlshell.key -out curlshell.crt -subj "/CN=$1"
