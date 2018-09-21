FROM maven:3.5.0-jdk-8-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

RUN git clone https://github.com/THLfi/termed-api.git && cd termed-api && git reset --hard 7979650b920b346fdc2ea13059d2917e4a74f074

WORKDIR /termed-api
RUN mvn package

ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "sleep 5 && java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /termed-api/target/termed-api-1.0-SNAPSHOT-exec.jar" ]
