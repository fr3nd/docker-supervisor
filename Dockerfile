FROM debian:jessie
MAINTAINER Carles Amigó, fr3nd@fr3nd.net

ENV SUPERVISOR_VERSION 3.1.3

RUN apt-get update && apt-get install -y \
      docker.io \
      python-pip \
      && rm -rf /var/lib/apt/lists/*
RUN pip install supervisor==$SUPERVISOR_VERSION
RUN mkdir -p /etc/supervisor/conf.d
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /etc/supervisor/conf.d
VOLUME /var/log/supervisor

ENTRYPOINT ["/entrypoint.sh"]
