# TFTP 서버 for docker container

이 컨테이너는 tftp 서비스를 구성합니다.

## 사용법
docker-compose 설정 파일로 다음과 같이 설정합니다.

```yaml
version: '2'

services:
  bind:
#   restart: always
    image: mcchae/tftp-server
    ports:
    - "69:69/udp"
    volumes:
    - ${PWD}/dhv/tftp:/var/tftpboot
```

## 테스트

### Install tftp-hpa
* Install tftp-hpa package. 
* /var/tftpboot is used for TFTP server directory.

```sh
$ sudo apk add tftp-hpa
$ sudo rc-update add in.tftpd
$ sudo rc-service in.tftpd start
```

### GET file with tftp
* Put file to /var/tftpboot.

```sh
$ echo "hello" | sudo tee /var/tftpboot/hello.txt
Get file with tftp from TFTP server.
$ echo "get hello.txt" | tftp 127.0.0.1
tftp> get hello.txt
tftp>
$ cat hello.txt
hello
```
