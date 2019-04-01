FROM alpine:latest
MAINTAINER Jerry <mcchae@gmail.com>

RUN apk add --no-cache tftp-hpa && mkdir -p /data

EXPOSE 69/udp
VOLUME /data

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "-u", "root", "--secure", "--create", "/data"]
