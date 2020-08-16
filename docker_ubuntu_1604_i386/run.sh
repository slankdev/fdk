#!/bin/sh
docker run -td --name frr_tmp --privileged \
  slankdev/frr-dev:ubuntu-16.04-i386
