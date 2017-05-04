---
date: 2016-03-09T00:11:02+01:00
title: Redns Configuration
weight: 10
---


## Configuration
Redns ships with pretty sane defaults, but many attributes are configurable:

```
[redns]
  loglevel          = "debug"
  dnsport           = 53
  upstreamdns       = "8.8.8.8:53"
  bootstrapdelay    = 1
  wildcardsubdomain = true

[redirect]
  redirectport      = 80
  useredirect       = true
  redirectsite      = ""
  redirectindex     = "deps/static/"

[redis]
  host              = "localhost:6379"
  password          = ""
```

- `[redns]`
  - `loglevel`: The verbosity of logs. acceptable fields are 'info', 'debug',
    and 'error'.
  - `dnsport`: The port the DNS server will bind to.
  - `upstreamdns`: The upstream DNS server to use, the default is google's
    public DNS server but you can use any. Syntax is `ip`:`port`
  - `bootstrapdelay`: A delay (in seconds) when redns starts up. this is useful when running with
    redis, this will eliminate any race condition. Use `0` for no delay.
  - `wildcardsubdomain`: Whether or not to use wildcard subdomains. For instance
    if the domain `yahoo.com` is blacklisted in the database, the domain
    `mail.yahoo.com` will also be blacklisted when the value is set to true.
    Use either `true` or `false` (boolean).

- `redirect`
  - `redirectport`: If using site redirection, redns will bind to this port and
    host the custom redirection page.
  - `useredirect`: Boolean to either use the site redirection feature or not. If
    set to false, clients DNS requests will be returned `RCODE3/NONEXIST` in case of a
    malicious site.
  - `redirectsite`: A custom site to redirect clients to.  If you have an
    existing warning site, set **the IP** here.  If this field is blank, redns
    will host a webpage for this.
  - `redirectindex`: Path to the static redirection page.

- `redis`:
  - `host`: Host where redis is listening. Syntax is `hostname/IP`:`port`
  - `password`: The password to redis if it exists
