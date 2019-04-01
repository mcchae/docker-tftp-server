FROM alpine:latest
MAINTAINER Jerry <mcchae@gmail.com>

RUN apk add --no-cache tftp-hpa

RUN apk update && \
    apk add --no-cache tftp-hpa=5.2-r2 && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* &&\
    mkdir -p /tftpboot

VOLUME /tftpboot

EXPOSE 69/udp

ENTRYPOINT ["/usr/sbin/in.tftpd"]
CMD ["--foreground", "--secure", "--verbose", "/tftpboot"]
