FROM debian
MAINTAINER David McCue

RUN apt-get update && \
    apt-get install -y python python-pip netcat git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install bottle requests

RUN git clone https://github.com/sstephenson/bats.git; \
	cd bats; \
	./install.sh /usr/local

EXPOSE 8080

COPY . /tmp/

CMD /tmp/server.py
