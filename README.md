# supervisor docker image

## Description

Supervisor is a client/server system that allows its users to monitor and
control a number of processes on UNIX-like operating systems.

This image allows you to run supervisor in a completelly containerized
environment

## How to use this image

Run supervisor with the default configuration (not of much use...):

```
docker run \
  --detach \
  --name supervisord \
  fr3nd/supervisor
```

Supervisor could be used to start a service running in the parent host's
docker. This example will start a collectd service and keep it running while
storing the logs in the parent's host /var/log/supervisor directory.

```
# Create configuration for the service
mkdir -p $HOME/supervisor.d
cat << EOF > $HOME/supervisor.d/collectd.conf
[program:collectd]
command=docker run --privileged -v /proc:/mnt/proc:ro fr3nd/collectd
EOF

# Run supervisord
docker run \
  --detach \
  --name supervisord \
  --volume /var/run/docker.sock:/var/run/docker.sock:rw \
  --volume $HOME/supervisor.d:/etc/supervisor/conf.d:ro \
  --volume /var/log/supervisor:/var/log/supervisor:rw \
  fr3nd/supervisor

# View status of the running services
docker exec \
  supervisord \
  supervisorctl status
```
