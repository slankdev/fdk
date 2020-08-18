#!/bin/sh
IMG=slankdev/frr-dev:ubuntu-16.04-i386
NAM=frr-ubuntu1604-i386
docker run -td --privileged \
  --memory=2000mb --memory-swap=2000mb --memory-swappiness=0 \
  -v /root/git/frr:/root/git/frr \
  -v /tmp:/tmp \
  --name $NAM --hostname $NAM $IMG
