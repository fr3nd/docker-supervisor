#!/bin/bash

set -e

ln -s /etc/supervisor/supervisord.conf /etc/supervisord.conf

if [ -z "$@" ]; then
  exec /usr/local/bin/supervisord -c /etc/supervisord.conf --nodaemon
else
  exec PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin $@
fi
