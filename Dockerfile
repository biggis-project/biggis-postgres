FROM biggis/base:java8-jre-alpine

MAINTAINER wipatrick

ENV PG_MAJOR=9.6.0
ENV PG_VERSION=9.6.0-r1

ENV LANG en_US.utf8
ENV PGDATA /opt/postgresql/data
ENV TZ Europe/Berlin

RUN set -x && \
    apk add --no-cache \
            tzdata \
            postgresql@edge=${PG_VERSION} \
            postgresql-contrib@edge=${PG_VERSION} && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    mkdir -p /var/lib/postgresql/data /var/lib/postgresql/initdb.d

ADD start.sh /var/lib/postgresql/

VOLUME ["/var/lib/postgresql/data/pgdata"]

EXPOSE 5432

ENTRYPOINT ["/var/lib/postgresql/start.sh"]
CMD ["postgres"]
