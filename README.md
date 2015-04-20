## ks-cli

Author: David McCue 2015

### Requirements (MACOS):

Tested on MacOS X Yosemite - 10.10.2

* brew
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
brew install boot2docker
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
* netcat - tcp connectivity test
~~~
brew install netcat
~~~

### Run:

To download files, setup and run automated tests please run:
~~~
git clone https://github.com/dmccue/ks-cli.git
cd ks-cli
./setup.sh
~~~

To manually use cli interface, cd to the cli directory after running ./setup.sh
~~~
./setup.sh
cd cli

./project
./back
./backer
./list
~~~