###############
# NGINX_STAGE #
###############

FROM nginx:alpine as nginx_stage

RUN rm -rf /etc/nginx/conf.d/* \
    && rm -rf /var/log/nginx/*

COPY nginx/logrotate.conf /etc/logrotate.d/nginx
COPY nginx/hound.conf /etc/nginx/conf.d/hound.conf


###############
# HOUND_STAGE #
###############

FROM alpine as hound_stage

ENV GOPATH /go

# Copy SSH key for git private repos
RUN mkdir /root/.ssh/
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Skip Host verification for git
RUN echo "StrictHostKeyChecking no" > /root/.ssh/config

RUN apk update \
    && apk add go git subversion libc-dev mercurial bzr openssh\
    && go get github.com/safrimus/hound/cmds/... \
    && apk del go \
    && rm -f /var/cache/apk/* \
    && rm -rf /go/src /go/pkg

RUN mkdir /data
COPY fetch-config.json /data/config.json

EXPOSE 6070

ENTRYPOINT ["/go/bin/houndd", "-conf", "/data/config.json", "-addr", ":6070"]
