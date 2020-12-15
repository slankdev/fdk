#!/bin/sh -xe
IMG=slankdev/frr-dev:ubuntu-20.04-amd64
NAM=frr-ubuntu2004-amd64
docker run -td --privileged \
  -v /root/git/frr:/root/git/frr \
  -v /tmp:/tmp \
  --name $NAM --hostname $NAM $IMG
