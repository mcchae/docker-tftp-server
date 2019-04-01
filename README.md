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

### start tftp

```sh
$ docker-compose up 
```

### GET file with tftp

* Put file to ${PWD}/dhv/tftp

```sh
$ echo "hello world" | tee ${PWD}/dhv/tftp/hello.txt
```

* Get file with tftp from TFTP server.

```sh
$ echo "get hello.txt" | tftp 127.0.0.1
tftp> get hello.txt
tftp>
$ cat hello.txt
hello world
```
