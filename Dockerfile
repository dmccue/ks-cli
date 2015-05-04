from gliderlabs/alpine
maintainer David McCue

copy server.py dbreset.py requirements.txt /tmp/

workdir /tmp

run apk --update add python py-pip git
run pip install -r requirements.txt && \
	mkdir db && \
	python dbreset.py

expose 8080

cmd python server.py