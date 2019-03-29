# Docker for Prana

[![Build Status](https://travis-ci.org/JoakimFristedt/prana.svg?branch=master)](https://travis-ci.org/JoakimFristedt/prana)

Simple implementation of a Docker image for [netflix prana](https://github.com/Netflix/Prana). Not all Prana/eureka properties are supported at the moment.

## Pull

```bash
docker pull joakimfristedt/prana
```

## Build

```bash
docker build -t joakimfristedt/prana .
```

## Run with default settings

```bash
docker run -p 8078:8078 joakimfristedt/prana
```

## Prana example with Elasticsearch

Register elasticsearch instance with Prana in [Eureka](https://github.com/Netflix/eureka)

```yaml
version: '3'
services:
  eureka:
    image: netflixoss/eureka:1.3.1
    container_name: eureka
    ports:
      - 8080:8080
    networks:
      - elastic

  prana-elastic:
    image: joakimfristedt/prana
    container_name: prana-elastic
    ports:
      - 8078
    networks:
      - elastic
    environment:
      - EUREKA_NAME=elasticsearch
      - EUREKA_PORT=9200
      - EUREKA_VIP_ADDRESS=elasticsearch

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch-oss:6.6.1
    container_name: elasticsearch
    ports:
      - 9200:9200
      - 9300:9300
    volumes:
      - elastic-data:/usr/share/elasticsearch/data
    networks:
      - elastic
    environment:
      - discovery.type=single-node 
      - cluster.name=elastic
networks:
  elastic:

volumes:
  elastic-data:
```

