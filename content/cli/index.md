---
date: 2016-03-09T00:11:02+01:00
title: Redns CLI
weight: 10
---

## CLI usage
Redns ships with a command line tool to access a list of client, access a
clients history, and add/remove malicious domains on the fly.  The following is
syntax on this tool.  

### Viewing attached clients
Any client that connects to redns is logged in the redis database. The command
for this is `view`.

- Example command: `./redns_cli list`
- Example output:  

```
DEBUG: 2017/05/04 05:05:31 redns_cli.go:35: connection to redis succeeded.
INFO: 2017/05/04 05:05:31 link to redis on localhost:6379
DEBUG: 2017/05/04 05:05:31 redns_cli.go:51: listing clients

CLIENTS:
[192.168.1.280 192.168.1.282 192.168.1.228]
```

### Getting client history
Redns will log the history (and timestamp) of any site browsed by a client. The
command for this is `get`.

- Example command: `./redis_cli get 192.168.1.280`
- Example output:

```
DEBUG: 2017/05/04 05:08:25 redns_cli.go:35: connection to redis succeeded.
INFO: 2017/05/04 05:08:25 link to redis on localhost:6379
DEBUG: 2017/05/04 05:08:25 redns_cli.go:63: getting client entries

HISTORY for '192.168.1.280':
  2017/04/02 03:05:36 :: clients4.google.com.
  2017/04/02 03:05:36 :: translate.googleapis.com.
  2017/04/02 03:05:36 :: safebrowsing.google.com.
  2017/04/02 03:05:36 :: www.googleapis.com.
  2017/04/02 03:05:36 :: accounts.google.com.
  2017/04/02 03:05:36 :: mtalk.google.com.
  2017/04/02 03:05:37 :: www.google-analytics.com.
```


### Adding malicious domain to database
Redns cli can add a malicious domain to the database on the fly. The command for
this is `add`.

- Example command: `./redis_cli add yahoo.com`
- Example output:

```
DEBUG: 2017/05/04 05:11:46 redns_cli.go:35: connection to redis succeeded.
INFO: 2017/05/04 05:11:46 link to redis on localhost:6379
DEBUG: 2017/05/04 05:11:46 redns_cli.go:74: adding 'yahoo.com' to blacklist
```

### Removing domain from the database
Redns cli can remove a malicious domain to the database on the fly. The command for
this is `del`.

- Example command: `./redis_cli del yahoo.com`
- Example output:

```
DEBUG: 2017/05/04 05:11:51 redns_cli.go:35: connection to redis succeeded.
INFO: 2017/05/04 05:11:51 link to redis on localhost:6379
DEBUG: 2017/05/04 05:11:51 redns_cli.go:84: removing 'yahoo.com' from blacklist
```


## Bulk adding blacklisted domains
Domains can be added to redis in bulk. Any public domain database can be used
when it is in the proper format.  
This is the syntax to add a single domain to the blacklist table:  
`redis-cli SADD blacklist:domain domain.name.here` where 'domain.name.here' is
the target domain to add.  

I personally use the [public list](http://www.malwaredomainlist.com/mdlcsv.php) from http://malwaredomainlist.com
and run it through a custom bash file to produce a consumable script (for adding
the domains).  Here is the script I wrote to do this: 

```
#!/bin/bash

# get domain list
wget -O domains.csv http://www.malwaredomainlist.com/mdlcsv.php

# get only the domains
awk -F "\"*,\"*" '{print $2}' domains.csv > domains.raw
rm domains.csv

# strip empty lines
sed '/-/d' ./domains.raw > domains.stripped
rm domains.raw

# strip forward slash
awk -F'/' '{print $1}' domains.stripped > domains.nohyphen
rm domains.stripped

# remove ports
awk -F':' '{print $1}' domains.nohyphen > domains.noport
rm domains.nohyphen

# remove empty lines
sed -i '/^$/d' domains.noport

# add redis command to beginning of file
awk '{print "redis-cli SADD blacklist:domain " $0;}' domains.noport > domains.redis
rm domains.noport

# rename file
mv domains.redis domains
echo "redis-cli SADD blacklist:domain not.a.domain.biz" >> domains
chmod +x domains
```

Running this bash script will produce a file `./domains` that when run will bulk
add the list to the local redis db.

To generate this list run `make generate_domain_list` from the root of the
project.

Example of loading the database:

```
make generate_domain_list
<domain list is generated>
./domains
<domains are added to local redis db>
```
