## ks-cli

Author: David McCue 2015

### Requirements (MACOS):

Tested on MacOS X Yosemite - 10.10.2

* brew - (MACOS only)
~~~
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
~~~
* docker
~~~
brew install docker
~~~
* git
~~~
brew install git
~~~
* boot2docker 1.6
~~~
Get dmg or tgz from http://boot2docker.io
~~~
* bats - testing framework
~~~
brew install bats
~~~
* python - python language runtimes
~~~
brew install python
~~~
* requests - rest client library
~~~
pip install requests
~~~

### Run:

To download files, setup and run automated tests please run:
~~~
git clone https://github.com/dmccue/ks-cli.git
cd ks-cli
./setup.sh
~~~

To manually use cli interface, cd to the cli directory
~~~
cd cli
~~~