#!/bin/sh -xe
IMG=slankdev/frr-dev:ubuntu-18.04-amd64
NAM=frr-ubuntu1804-amd64
docker run -td --privileged \
  -v /root/git/frr:/root/git/frr \
  -v /tmp:/tmp \
  --name $NAM --hostname $NAM $IMG
