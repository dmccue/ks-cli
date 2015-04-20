#!/usr/bin/env bash

which docker &>/dev/null || ( echo Please install docker: https://docs.docker.com/installation/; exit 1 )
echo
echo Building docker image
docker build -t ks-restserver .
echo
echo "Running docker image (server)"
docker kill ks-restserver &>/dev/null
docker rm ks-restserver &>/dev/null
docker run --name ks-restserver -p 8080:8080 -d ks-restserver
echo
echo Beginning tests
./test.sh
echo
echo Please cd into the cli directory to run manual steps
echo