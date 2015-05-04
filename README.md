## ks-cli

Author: David McCue 2015

### Requirements (MACOS):

Tested on MacOS X Yosemite - 10.10.2

* homebrew
~~~
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
~~~
* Brew dependencies - python/docker/git/boot2docker/bats/netcat
~~~
brew install python docker git boot2docker bats netcat
~~~
* Python dependencies - requests
~~~
pip install requests
~~~

### Run:

To download files, setup and run automated tests please run:
~~~
git clone https://github.com/dmccue/ks-cli.git
cd ks-cli
. ./setup.sh
~~~

To manually use cli interface, cd to the cli directory after running ./setup.sh
~~~
cd cli

./project
./back
./backer
./list
~~~

### Tests:

To run repeatable tests using docker run:
~~~
bats tests
~~~

### Logs:

In order to display realtime logging internally on the REST server, please run:

~~~
view logs:
docker logs -f ks-restserver
or interactively:
docker exec -it ks-restserver bash
~~~
