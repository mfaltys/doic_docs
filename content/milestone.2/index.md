---
date: 2016-03-09T00:11:02+01:00
title: Milestone 2
weight: 10
---

## Architectural Diagram
![architectural diagram](https://s3.amazonaws.com/unixvoid-blog/doic_architectural_diagram_v2.png)

### Components
The following components are used in this tool:  

- **DOIC**: The main tool itself, comprised of components to parse the DNS
  request recieved, check the requested domain against the malicious domain list
  (in redis), and resolving the request upstream if it is deemed safe.  
  Listens on `TCP:53`.
- **Redis DB**: The redis db (listens on `TCP:6379`) containing the following data sets:  
    - `blacklist:domain`: contains a [redis set](https://redis.io/commands/set)
      of blacklisted domains.
    - `client:list`: contains the [redis set](https://redis.io/commands/set) of
      clients registered in the system.
    - `client:<client_ip>`: contains the [ordered redis set](https://redis.io/commands/rpush)
      of domains (with timestamp) that the specified client has browsed.  
- **DOIC Cli**: The doic cli is a command line tool used to browse connected
  users, browse connected users history, and enter domains into the blacklisted
  domain list.  The cli connect to redis on its configured port (default
  `TCP:6379`).

## Activity Diagram
![activity diagram](https://s3.amazonaws.com/unixvoid-blog/doic_activity_diagram.png)

## User story relization
