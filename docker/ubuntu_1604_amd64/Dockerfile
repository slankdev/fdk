FROM ubuntu:xenial
MAINTAINER Hiroki Shirokura <slank.dev@gmail.com>

RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo

## To Build FRR
RUN apt-get update && apt-get install -y \
   git autoconf automake libtool make libreadline-dev texinfo \
   pkg-config libpam0g-dev libjson-c-dev bison flex python3-pytest \
   libc-ares-dev python3-dev libsystemd-dev python-ipaddress python3-sphinx \
   install-info build-essential libsystemd-dev libsnmp-dev perl libcap-dev
ADD https://ci1.netdef.org/artifact/LIBYANG-YANGRELEASE/shared/build-10/Debian-AMD64-Packages/libyang-dev_0.16.105-1_amd64.deb /tmp
ADD https://ci1.netdef.org/artifact/LIBYANG-YANGRELEASE/shared/build-10/Debian-AMD64-Packages/libyang0.16_0.16.105-1_amd64.deb /tmp
RUN cd /tmp && apt install -y ./*.deb

## Fot Topotest
RUN apt-get update && apt-get install -y  mininet python-pip iproute2 gdb
RUN pip install --upgrade pip \
 && pip install ipaddr "pytest<5" exabgp==3.4.17 pyutil zip\
 && useradd -d /var/run/exabgp/ -s /bin/false exabgp

## Create User
RUN addgroup --system --gid 92 frr \
 && addgroup --system --gid 85 frrvty \
 && adduser --system --ingroup frr \
    --home /var/run/frr/ \
    --shell /bin/false frr \
    --gecos "FRRouting suite" \
 && usermod -G frrvty frr

RUN echo ". /etc/bash_completion" >> /root/.bashrc
COPY ./docker-start.sh /usr/bin/docker-start.sh
ENTRYPOINT [ "/usr/bin/docker-start.sh" ]
