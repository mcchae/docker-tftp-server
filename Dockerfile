FROM alpine:latest
MAINTAINER Jerry <mcchae@gmail.com>

RUN apk add --no-cache tftp-hpa

EXPOSE 69/udp
VOLUME /var/tftpboot

ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--verbose", "--secure", "/var/tftpboot"]
