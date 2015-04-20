#!/bin/bash
which bats || ( echo Please install bats from https://github.com/sstephenson/bats; exit 1 ) 
bats tests/test.bats
