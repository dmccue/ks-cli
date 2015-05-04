#!/usr/bin/env bash

echo INFO: Create symlinks
echo
mkdir -p cli
ln -sf ../client.py cli/back
ln -sf ../client.py cli/backer
ln -sf ../client.py cli/list
ln -sf ../client.py cli/project
which docker &>/dev/null || ( echo Please install docker: https://docs.docker.com/installation/; exit 1 )
boot2docker up &>/dev/null
eval "$(boot2docker shellinit)" &>/dev/null
echo
echo INFO: Building docker image
docker build -t ks-restserver .
echo
echo "INFO: Running docker image (server)"
docker kill ks-restserver &>/dev/null
docker rm ks-restserver &>/dev/null
docker run --name ks-restserver -p 8080:8080 -d ks-restserver
VBoxManage controlvm boot2docker-vm natpf1 "ks-restserver,tcp,127.0.0.1,8080,,8080" &>/dev/null
echo
echo INFO: Beginning tests
which bats || ( echo Please install bats from https://github.com/sstephenson/bats; exit 1 ) 
bats tests/test.bats && \
  echo INFO: Tests completed successfully || \
  ( echo ERROR: Tests did not finish successfully; exit 1 )
echo
echo INFO: Please cd into the cli directory to run manual steps
echo
