FROM alpine:3.5

ENV APK_MIRROR http://mirror.leaseweb.com

RUN echo "$APK_MIRROR/alpine/v3.5/main" > /etc/apk/repositories
RUN echo "@community $APK_MIRROR/alpine/v3.5/community" >> /etc/apk/repositories

ENV DB_USER mongodb
ENV DB_PASSWORD mongodb
ENV DB_ROLE dbOwner
ENV DB_STORAGE_ENGINE mmapv1
ENV DB_JOURNALING nojournal
ENV DB_MOUNTPOINT /mongodb/data

#https://pkgs.alpinelinux.org/package/edge/testing/x86_64/mongodb

ENV GLIBC_VERSION 2.23-r3
ENV MONGODB_VERSION 3.2.8
ENV MONGODB_PORT 27017

EXPOSE $MONGODB_PORT

VOLUME $DB_MOUNTPOINT
RUN mkdir -p $DB_MOUNTPOINT

RUN apk add --update \
    && apk add curl libgcc libstdc++ \
    && cd tmp \
    && curl -SLo- https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGODB_VERSION}.tgz | tar xz \
    && curl -Lo /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && curl -Lo glibc.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" \
    && apk add glibc.apk \
    && curl -Lo glibc-bin.apk "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" \
    && apk add glibc-bin.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf \
    && mv mongodb-linux-x86_64-${MONGODB_VERSION}/bin/* /usr/bin/ \
    && rm -rf glibc.apk glibc-bin.apk /tmp/* /var/cache/apk/*

RUN mkdir -p $DB_MOUNTPOINT

CMD rm /mongodb/data/mongod.lock || true && \
  /usr/bin/mongod \
  --dbpath $DB_MOUNTPOINT \
  --port $MONGODB_PORT \
  --storageEngine $DB_STORAGE_ENGINE \
  --$DB_JOURNALING
