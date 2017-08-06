FROM nimmis/alpine-glibc

MAINTAINER nimmis <kjell.havneskold@gmail.com>

ENV RSLSYNC_SIZE=1000 \
    RSLSYNC_TRASH_TIME=30 \
    RSLSYNC_TRASH=true
COPY root/. /

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    apk update && apk upgrade && \
    apk add zip curl mhddfs && \
    cd /root && \
    curl https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz | tar xfz - && \
    mv rslsync /usr/local/bin && \
    rm -rf /var/cache/apk/*

VOLUME /data

EXPOSE 33333
EXPOSE 8888

ENTRYPOINT mkdir /actual-sync-folder \
    && mhddfs $RSLSYNC_PATH,$RSLSYNC_PATH /actual-sync-folder \
    && /boot.sh


# docker run .... --privileged and --device /dev/fuse ...
#  details here: https://github.com/gliderlabs/docker-alpine/issues/268

