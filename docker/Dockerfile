FROM debian:stretch

RUN apt-get update && apt-get install -y build-essential pxz file git wget cpio python unzip bc sudo bmap-tools libncurses-dev && apt-get clean

VOLUME /src
WORKDIR /src

CMD ["make", "minimal"]
