FROM nimmis/alpine-glibc

MAINTAINER nimmis <kjell.havneskold@gmail.com>

ENV RSLSYNC_SIZE=1000 \
    RSLSYNC_TRASH_TIME=30 \
    RSLSYNC_TRASH=true
COPY root/. /

LABEL com.resilio.version="2.5.10"

RUN apk update && apk upgrade && \
    apk add zip curl && \
    cd /root && \
    curl https://download-cdn.resilio.com/2.5.10/linux-x64/resilio-sync_x64.tar.gz | tar xfz - && \
    mv rslsync /usr/local/bin && \
    rm -rf /var/cache/apk/*

VOLUME /data

EXPOSE 33333
EXPOSE 8888

