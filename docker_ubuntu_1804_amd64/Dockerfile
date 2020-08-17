FROM ubuntu:bionic
MAINTAINER Hiroki Shirokura <slank.dev@gmail.com>

RUN apt update && apt install -y tzdata
ENV TZ=Asia/Tokyo

RUN apt install -y \
	 vim tmux iproute2 bash-completion \
   sudo git autoconf automake libtool make libreadline-dev texinfo \
   pkg-config libpam0g-dev libjson-c-dev bison flex python3-pytest \
   libc-ares-dev python3-dev libsystemd-dev python-ipaddress python3-sphinx \
   install-info build-essential libsystemd-dev libsnmp-dev perl libcap-dev \
   mininet python-pip iproute2 gdb \
 && pip install ipaddr "pytest<5" exabgp==3.4.17 \
 && useradd -d /var/run/exabgp/ -s /bin/false exabgp

ADD https://ci1.netdef.org/artifact/LIBYANG-YANGRELEASE/shared/build-10/Debian-AMD64-Packages/libyang-dev_0.16.105-1_amd64.deb /tmp
ADD https://ci1.netdef.org/artifact/LIBYANG-YANGRELEASE/shared/build-10/Debian-AMD64-Packages/libyang0.16_0.16.105-1_amd64.deb /tmp
RUN cd /tmp && apt install -y ./*.deb

RUN echo ". /etc/bash_completion" >> /root/.bashrc
COPY ./docker-start.sh /usr/bin/docker-start.sh
ENTRYPOINT [ "/usr/bin/docker-start.sh" ]
