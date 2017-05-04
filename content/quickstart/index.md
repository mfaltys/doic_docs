---
date: 2016-03-09T00:11:02+01:00
title: Redns Quickstart/Configuration
weight: 10
---

## Quickstart
The easiest way to get started quickly is to grab one of our pre-built binaries
or containers.  

You will also need redis to be populated with blacklisted domains. See the
**Redns CLI Commands** page for help with this, or just run the following from
the root of the project:

```
make generate_domain_list
./domains
```

### Rkt container
The prefered and fastest way to get on your feet is to grab our public rkt container.
You can do this by issuing `rkt fetch unixvoid.com/redns`. To accompany this rkt container,
we provide basic [systemd service file](https://github.com/mfaltys/redns/blob/develop/deps/redns.service)
to get you started right away.  

If you need help installing rkt checkout the [getting started](https://github.com/rkt/rkt/blob/master/Documentation/getting-started-guide.md)
page released by rkt.  

The rkt containers come preconfigured with [sane defaults](https://github.com/mfaltys/redns/blob/develop/config.gcfg)
and have redis as an attached pod (see [systemd service file](https://github.com/mfaltys/redns/blob/develop/deps/redns.service)).
If you need more custom configurations, check out the *Configuration* page.

Example usage:

```
cp deps/redns.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo rkt fetch unixvoid.com/redns
sudo systemctl start redns
```

### Docker container
We have public docker images available over on the
[dockerhub](https://hub.docker.com/r/mfaltys/redns/).  
To quickly run the docker image issue the following command: `docker run mfaltys/redns`.  

To actually use the container, lets bind to some ports: `docker run -d -p 80:80 -p 53:53 mfaltys/redns`.  
This will expose ports `80` and `53` on the host for the web interface and dns respectively.

Here is a more complex example showing how to link in a custom config file and
making the redis db available on the host machine:  

```
docker run \
	-d \
	-p 80:80 \
	-p 53:53 \
	-v /path/to/config.gcfg:/config.gcfg \
	-v /path/to/redis_dir/:/redisbackup/ \
	mfaltys/redns
```


### Precompiled binaries
Using a precompiled binary is the best way to build a custom install but involves a bit more work.

- Grab the server binary: [redns binary for amd64
architecture](https://cryo.unixvoid.com/bin/redns/redns-latest-linux-amd64)  
- Grab the cli binary: [redns cli binary for amd64](https://cryo.unixvoid.com/bin/redns/redns_cli-latest-linux-amd64)  
- Install redis: you can install directly on the host **or** grab a vanilla container image
(any vanilla install of redis will work for redns):
  - Rkt/ACI: `rkt fetch unixvoid/redis`
  - Docker: `docker pull unixvoid/redis`
- Get a [configuration file](https://github.com/mfaltys/redns/blob/develop/config.gcfg)
and place it in the same directory as the *server binary*. (for configuration options
see the *Configuration* page.)
- Now you are all set to run redns, just execute the binary.
