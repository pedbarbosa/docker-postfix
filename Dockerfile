FROM alpine:latest

RUN apk --update upgrade && \
    apk add curl cyrus-sasl postfix rsyslog supervisor && \
    find /usr/lib -regex '^.*\(__pycache__\|\.py[co]\)$' -delete && \
    rm -rf /var/cache/apk/*

COPY root/ /

RUN chmod +x /run.sh && \
    mkdir /config && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/run/supervisor

EXPOSE 25
CMD ["/run.sh"]

