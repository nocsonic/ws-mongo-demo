FROM alpine:3.7

ENV APK_MIRROR http://mirror.leaseweb.com

LABEL authors="Vernon Chapman <g8tor692@gmail.com>"

ENV MONGO_DB_USER mongodb
ENV MONGO_DATA_DIR /data/mongo/db

# Add System PAckages
RUN apk --no-cache add mongodb && \
    mkdir -p $MONGO_DATA_DIR && \
    chown -R $MONGO_DB_USER:$MONGO_DB_USER $MONGO_DATA_DIR

VOLUME [ $MONGO_DATA_DIR ]

EXPOSE 27017

USER mongodb

CMD /usr/bin/mongod --dbpath $MONGO_DATA_DIR
