#!/usr/bin/env bash

which docker &>/dev/null || ( echo Please install docker: https://docs.docker.com/installation/; exit 1 )
boot2docker up
boot2docker shellinit
echo
echo Building docker image
docker build -t ks-restserver .
echo
echo "Running docker image (server)"
docker kill ks-restserver &>/dev/null
docker rm ks-restserver &>/dev/null
docker run --name ks-restserver -p 8080:8080 -d ks-restserver
VBoxManage controlvm boot2docker-vm natpf1 "ks-restserver,tcp,127.0.0.1,8080,,8080" &>/dev/null
echo
echo Beginning tests
which bats || ( echo Please install bats from https://github.com/sstephenson/bats; exit 1 ) 
bats tests/test.bats
echo
echo Please cd into the cli directory to run manual steps
echo