#!/bin/sh

function _fdk_mininet_nsenter_CONTAINER() {
  # USAGE: $0 <container-name>

  CONTAINER_NAME=$1
  docker exec $CONTAINER_NAME \
    pgrep -af "bash --norc -is mininet" \
    | awk '{print $5}' \
    | awk -F ':' '{print $2}'
}

function _fdk_nsenter() {
  local args
  case $COMP_CWORD in
  1) args=$(docker ps --format "{{.Names}}") ;;
  2) args=$(_fdk_mininet_nsenter_CONTAINER ${COMP_WORDS[1]}) ;;
  esac

  COMPREPLY=( `compgen -W "$args" -- ${COMP_WORDS[COMP_CWORD]}` )
}

function _fdk_list() {
  local args
  case $COMP_CWORD in
  1) args=$(docker ps --format "{{.Names}}") ;;
  esac

  COMPREPLY=( `compgen -W "$args" -- ${COMP_WORDS[COMP_CWORD]}` )
}

function fdk-nsenter() {
  if [ $# -ne 2 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container-name> <mininet-node>" 1>&2
    return 1
  fi
  PID=$(docker exec $1 pgrep -f "bash --norc -is mininet:$2")
  echo EXECUTE: docker exec -it $1 nsenter -t $PID -a bash --norc
  docker exec -it $1 nsenter -t $PID -a bash --norc
}

function fdk-list() {
  if [ $# -ne 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container-name>" 1>&2
    return 1
  fi
  docker exec $1 pgrep -af "bash --norc -is mininet:"
}

function fdk-exec-it() {
  if [ $# -lt 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container> <cmd...>" 1>&2
    return 1
  fi
  docker exec -it $*
}

function fdk-exec() {
  if [ $# -lt 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container>" 1>&2
    return 1
  fi
  docker exec $*
}

function fdk-build() {
  if [ $# -ne 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container-name>" 1>&2
    return 1
  fi
  docker exec $1 bash -c "\
    cd /root/git/frr && \
    make -j8 && \
    make -j8 install \
  "
}

function fdk-build-full() {
  if [ $# -ne 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container-name>" 1>&2
    return 1
  fi
  docker exec $1 bash -c "\
    cd /root/git/frr && \
    ./bootstrap.sh && \
    ./configure \
      --prefix=/usr \
      --localstatedir=/var/run/frr \
      --sbindir=/usr/lib/frr \
      --sysconfdir=/etc/frr \
      --enable-vtysh \
      --enable-pimd \
      --enable-sharpd \
      --enable-multipath=64 \
      --enable-user=frr \
      --enable-group=frr \
      --enable-vty-group=frrvty \
      --enable-address-sanitizer \
      --with-pkg-extra-version=-fdk-test && \
    make -j8 clean && \
    make -j8 && \
    make -j8 install \
  "
}

function fdk-topotest() {
  if [ $# -lt 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <container>" 1>&2
    return 1
  fi
  docker exec -it $1 bash -c "\
    cd /root/git/frr && \
    make -j8 && \
    make -j8 install && \
    cd /root/git/frr/tests/topotests/srv6_manager && \
    ./test_srv6_manager.py $2 \
  "
}

complete -F _fdk_list    fdk-list
complete -F _fdk_list    fdk-build
complete -F _fdk_list    fdk-build-full
complete -F _fdk_list    fdk-exec
complete -F _fdk_list    fdk-exec-it
complete -F _fdk_list    fdk-topotest
complete -F _fdk_nsenter fdk-nsenter
