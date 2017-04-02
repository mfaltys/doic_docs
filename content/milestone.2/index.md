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

### Add new blacklisted domain
- As an administrator, I want to add new blacklisted domains to keep my client
  safe.
![activity diagram 1](https://s3.amazonaws.com/unixvoid-blog/doic_activity_diagram_1_blacklist_domain.png)

### Track client traffic
- As an administrator, I want to follow traffic on a per-ip basis to track down
  malicious software swiftly.
![activity diagram 2](https://s3.amazonaws.com/unixvoid-blog/doic_activity_diagram_2_client_traffic.png)

### Malicious traffic alerting
- As an administrator, I want to be alerted of malicious intent to keep my users
  safe.
![activity diagram 3](https://s3.amazonaws.com/unixvoid-blog/doic_activity_diagram_3_alerting.png)


## User story relization
The following resources will be used in demoing doic and the doic_cli:  

- [browse doic resources](https://cryo.unixvoid.com/bin/doic/)  
- [doic](https://cryo.unixvoid.com/bin/doic/doic-latest-linux-amd64)  
- [doic_cli](https://cryo.unixvoid.com/bin/doic/doic_cli-latest-linux-amd64)  

## Next milestone planning
The next milestone has been planned and is in the 'Selected For
Development/Sprint TODO' in [trello](https://trello.com/b/5KMHrR6L/doic).  
Please note that is is tentative and ever changing as the current sprint work is
wrapping up now and we are phasing in the next sprint.  The cards will move even
if the 'current progress' is not tracked.
