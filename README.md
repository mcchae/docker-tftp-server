# TFTP 서버 for docker container

이 컨테이너는 tftp 서비스를 구성합니다.

## 사용법
docker-compose 설정 파일로 다음과 같이 설정합니다.

```yaml
version: '2'

services:
  tftp:
    image: mcchae/tftp-server
    container_name: tftp_server
    ports:
    - "6969:69/udp"
    volumes:
    - ${PWD}/dhv/tftp:/data
  tftptest:
    image: mcchae/tftp-server
    container_name: tftp_client
    links:
    - tftp
    command: /bin/sleep 1000
  tftptest2:
    image: ubuntu
    container_name: tftp_client2
    links:
    - tftp
    command: sleep 1000
```

* tftptest 및 tftptest2 는 테스트용 컨테이너
* mac 에서 tftp로 테스트를 하니 연동 안되지만, 위의 테스트 컨테이너에서는 잘 되었음

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

## 주의할 점
docker 디폴트 bridge 모드에서 테스트 할 경우, TFTP 프로토콜은 host로 열려있는 UDP port 이외에 다른 포트를 사용합니다.

```txt
/ # tcpdump -nn -i any udp
09:10:03.220626 IP6 ::1.57605 > ::1.69:  21 RRQ "hello.txt" netascii
09:10:03.253923 IP6 ::1.53294 > ::1.57605: UDP, length 17
09:10:03.253923 IP6 ::1.53294 > ::1.57605: UDP, length 17
...
```

따라서 docker host 에서 테스트 할 경우에는, 다음과 같이 `docker-compose.yaml` 파일에서 `network_mode`를 host로 해 줍니다.

```yaml
version: '3.4'

services:
  tftp:
    network_mode: "host"
    image: mcchae/tftp-server
    container_name: tftp_server
    ports:
    - "69:69/udp"
    volumes:
    - ${PWD}/dhv/tftp:/data
    #command: in.tftpd -L -vvv -a 0.0.0.0:69 -u root --secure --create /data
    command: in.tftpd -L -vvv -a :69 -u root --secure --create /data
  tftptest:
    network_mode: "host"
    #image: mcchae/tftp-server
    image: mcchae/py37
    container_name: tftp_client
    volumes:
    - ${PWD}/dhv/test:/test
    #links:
    #- tftp
    command: /bin/sleep 100000
```

