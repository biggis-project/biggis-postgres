FROM biggis/base:java8-jre-alpine

MAINTAINER wipatrick

ARG PG_MAJOR=9.6.0
ARG PG_VERSION=9.6.0-r1

ARG BUILD_DATE
ARG VCS_REF

LABEL eu.biggis-project.build-date=$BUILD_DATE \
      eu.biggis-project.license="MIT" \
      eu.biggis-project.name="BigGIS" \
      eu.biggis-project.url="http://biggis-project.eu/" \
      eu.biggis-project.vcs-ref=$VCS_REF \
      eu.biggis-project.vcs-type="Git" \
      eu.biggis-project.vcs-url="https://github.com/biggis-project/biggis-infrastructure" \
      eu.biggis-project.environment="dev" \
      eu.biggis-project.version=$FLINK_VERSION

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
