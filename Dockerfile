FROM anapsix/alpine-java:8

ENV PRANA_VERSION "0.0.1"

ENV EUREKA_NAME "default"
ENV EUREKA_PORT "8000"
ENV EUREKA_VIP_ADDRESS $EUREKA_NAME
ENV EUREKA_SERVICE_URL_DEFAULT "http://eureka:8080/eureka/v2/"
ENV EUREKA_VALIDATE_INSTANCE_ID "false"
ENV PRANA_HOST_HEALTHCHECK_URL "http://$\{eureka.name\}:$\{eureka.port\}"

WORKDIR /opt

RUN apk add --no-cache wget unzip bash

RUN wget http://dl.bintray.com/netflixoss/Prana/Prana-$PRANA_VERSION.zip

RUN unzip Prana-$PRANA_VERSION.zip

RUN mv Prana-$PRANA_VERSION prana

WORKDIR /opt/prana

ENTRYPOINT JAVA_OPTS="-Deureka.name=$EUREKA_NAME -Deureka.port=$EUREKA_PORT -Deureka.vipAddress=$EUREKA_VIP_ADDRESS -Deureka.serviceUrl.default=$EUREKA_SERVICE_URL_DEFAULT -Deureka.validateInstanceId=$EUREKA_VALIDATE_INSTANCE_ID -Dprana.host.healthcheck.url=$PRANA_HOST_HEALTHCHECK_URL" bin/Prana -p 8078

EXPOSE 8078
