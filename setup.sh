#!/usr/bin/env bash

echo INFO: Creating docker environment
which docker &>/dev/null || ( echo Please install docker: https://docs.docker.com/installation/; exit 1 )
boot2docker up &>/dev/null
eval "$(boot2docker shellinit)" &>/dev/null
VBoxManage controlvm boot2docker-vm natpf1 "ks-restserver,tcp,127.0.0.1,8080,,8080" &>/dev/null
echo
echo INFO: Building docker image
docker build -t ks-restserver .
echo
echo INFO: Beginning tests
which bats || ( echo Please install bats from https://github.com/sstephenson/bats; exit 1 ) 
bats tests && \
  echo INFO: Tests completed successfully || \
  ( echo ERROR: Tests did not finish successfully; exit 1 )
echo
echo INFO: Please cd into the cli directory to run manual steps
echo
