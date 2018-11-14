# Hound

This is a fork of https://github.com/etsy/hound.

Hound is an extremely fast source code search engine. The core is based on this article (and code) from Russ Cox:
[Regular Expression Matching with a Trigram Index](http://swtch.com/~rsc/regexp/regexp4.html). Hound itself is a static
[React](http://facebook.github.io/react/) frontend that talks to a [Go](http://golang.org/) backend. The backend keeps an up-to-date index for each repository and answers searches through a minimal API. Here it is in action:

![Hound Screen Capture](screen_capture.gif)

## Quick Start Guide

1. Use the Go tools to install Hound to your $GOPATH:
```
go get github.com/safrimus/hound/cmds/...
```

2. (Optional) Create an updated version of [fetch-config.json](deployment/fetch-config.json) using the
[config_generator.py](scripts/config_generator.py) script.

3. Run
```
cd hound/deployment
cp ~/.ssh/id_rsa .
docker-compose up --build -d
```

You should then be able to navigate to [http://localhost:6080/](http://localhost:6080/).

## Requirements
* Go 1.4+
