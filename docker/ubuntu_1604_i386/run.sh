#!/bin/sh
IMG=slankdev/frr-dev:ubuntu-18.06-i386
NAM=frr-ubuntu1604-i386
docker run -td --privileged \
  -v /root/git/frr:/root/git/frr \
  -v /tmp:/tmp \
  --name $NAM -hostname $NAM $IMG
