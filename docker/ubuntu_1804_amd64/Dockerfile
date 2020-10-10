FROM ubuntu:bionic
MAINTAINER Hiroki Shirokura <slank.dev@gmail.com>

RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt update && apt install -y \
   vim tmux iproute2 bash-completion \
   sudo git autoconf automake libtool make libreadline-dev texinfo \
   pkg-config libpam0g-dev libjson-c-dev bison flex python3-pytest \
   libc-ares-dev python3-dev libsystemd-dev python-ipaddress python3-sphinx \
   install-info build-essential libsystemd-dev libsnmp-dev perl libcap-dev
ADD https://ci1.netdef.org/artifact/LIBYANG-LY1REL/shared/build-4/Ubuntu-20.04-x86_64-Packages/libyang-dev_1.0.184-4-gf0cf7120-1~1.gbp1b59fa_amd64.deb /tmp
ADD https://ci1.netdef.org/artifact/LIBYANG-LY1REL/shared/build-4/Ubuntu-20.04-x86_64-Packages/libyang1_1.0.184-4-gf0cf7120-1~1.gbp1b59fa_amd64.deb /tmp
RUN cd /tmp && apt install -y ./*.deb

## Fot Topotest
RUN apt update && apt install -y mininet python-pip iproute2 gdb
RUN pip install --upgrade pip \
 && pip install ipaddr "pytest<5" exabgp==3.4.17 \
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
