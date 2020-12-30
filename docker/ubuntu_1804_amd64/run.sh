#!/bin/sh -xe
mkdir -p /usr/share/nginx/html
IMG=slankdev/frr-dev:ubuntu-18.04-amd64
NAM=frr-ubuntu1804-amd64
docker run -td --privileged \
  -v /root/git/frr:/root/git/frr \
  -v /tmp:/tmp \
  -v /usr/share/nginx/html:/pcap \
  --name $NAM --hostname $NAM $IMG

#--memory=8000mb \
#--memory-swap=8000mb \
#--memory-swappiness=0 \
#
