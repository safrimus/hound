FROM alpine

ENV GOPATH /go

COPY . /go/src/github.com/safrimus/hound

COPY fetch-config.json /data/config.json

# Copy SSH key for git private repos
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Skip Host verification for git
RUN echo "StrictHostKeyChecking no" > /root/.ssh/config

RUN apk update \
	&& apk add go git subversion libc-dev mercurial bzr openssh \
	&& go install github.com/safrimus/hound/cmds/houndd \
	&& apk del go \
	&& rm -f /var/cache/apk/* \
	&& rm -rf /go/src /go/pkg

VOLUME ["/data"]

EXPOSE 6080

ENTRYPOINT ["/go/bin/houndd", "-conf", "/data/config.json"]
