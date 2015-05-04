FROM gliderlabs/alpine:3.1
MAINTAINER David McCue

RUN apk --update add python py-pip git

RUN pip install bottle requests

EXPOSE 8080

COPY . /tmp/

CMD /tmp/server.py
