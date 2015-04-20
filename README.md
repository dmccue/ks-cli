## ks-cli

Author: David McCue 2015

### Requirements:

Tested on MacOS X Yosemite - 10.10.2

* git
~~~
apt-get install git
~~~
* boot2docker 1.6
* bats - testing framework
~~~
git clone https://github.com/sstephenson/bats.git; \
cd bats; \
./install.sh /usr/local
~~~
* python - python language runtimes
~~~
apt-get install -y python
~~~
* python-pip - python package installer
~~~
apt-get install -y python-pip
~~~
* requests - rest client library
~~~
pip install requests
~~~

### Run:

~~~
git clone https://github.com/dmccue/ks-cli.git
cd ks-cli
./setup.sh
~~~