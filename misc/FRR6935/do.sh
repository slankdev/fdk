#!/bin/sh -xe

function create_container() {
  if [ $# -ne 5 ]; then
          echo "invalid command syntax" 1>&2
          echo "Usage: $0 <image> <name-prefix> <mem> <mem-swap> <mem-swappiness>" 1>&2
          exit 1
  fi
  NAME=$2-$3-$4-$5
  docker run -td --rm --privileged \
    --memory=$3 \
    --memory-swap=$4 \
    --memory-swappiness=$5 \
    -v /root/git/frr:/root/git/frr \
    -v /tmp:/tmp \
    --name $2-$3-$4-$5 \
    --hostname $2-$3-$4-$5 \
    $1
}

function route_scale_test() {
  if [ $# -ne 2 ]; then
          echo "invalid command syntax" 1>&2
          echo "Usage: $0 <base-commit> <size>" 1>&2
          exit 1
  fi

}

create_container slankdev/frr-dev:ubuntu-18.04-amd64 ubuntu1804-amd64 2000mb 2000Mb 0
create_container slankdev/frr-dev:ubuntu-16.04-amd64 ubuntu1604-amd64 2000mb 2000Mb 0
