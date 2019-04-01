FROM ubuntu:14.04
MAINTAINER Jerry <mcchae@gmail.com>

# Install tftpd-hpa deamon
RUN apt-get update
RUN apt-get install -y tftpd-hpa
VOLUME /var/lib/tftpboot

EXPOSE 69

CMD /usr/sbin/in.tftpd --foreground --user tftp --address 0.0.0.0:69 --secure /var/lib/tftpboot
