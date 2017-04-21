---
date: 2016-03-08T21:07:13+01:00
title: DNS based IOC
type: index
weight: 0
---

[![Build Status (Travis)](https://travis-ci.org/mfaltys/redns.svg?branch=master)](https://travis-ci.org/mfaltys/redns)  
Redns is a DNS based indicator of compromise (IOC) written in go.  This tool is designed to be a very low
overhead plug-and-play approach to implimenting an IOC for organizational or
personal use.  If you want to track our day-to-day activities, check out our
[trello board](https://trello.com/b/5KMHrR6L/project-requirement-clicitation-cybr4580).


## Using redns

### Getting precompiled binaries
This project pushes up a binary on every project commit and tag.
You can find these binaries in the following locations (note we only pre compile
for 64 bit linux architectures):  
[browse binaries](https://cryo.unixvoid.com/bin/redns/)  
[latest redns](https://cryo.unixvoid.com/bin/redns/redns-latest-linux-amd64)  
[latest redns_cli](https://cryo.unixvoid.com/bin/redns/redns_cli-latest-linux-amd64)


### Compiling from source
Redns uses Make for compilation/testing.  Use the following commands to buid redns
from source.

- First make sure you have golang installed and configured
- To pull all dependencies use `make dependencies`
- To build dynamically use `make` or `make redns`
  - The dynamically compiled binary will end up in the `bin/` directory
- To build statically use `make stat`
  - The statically compiled binary will end up in the `bin/` directory
- To build the cli use `make stat_cli`
  - The portable binary will end up in the `bin/` directory
- To clean up all compiled binaries use `make clean`
