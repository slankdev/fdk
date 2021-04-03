FDK_FRR_PATH=~/frr.frrouting
FDK_FRR_PATH=~/frr
FDK_TOPOTEST_TARGET=bgp_multi_vrf_topo2/test_bgp_multi_vrf_topo2.py
FDK_TOPOTEST_TARGET=bgp_multi_vrf_topo1/test_bgp_multi_vrf_topo1.py
FDK_TOPOTEST_TARGET=bgp_l3vpn_to_bgp_vrf/test_bgp_l3vpn_to_bgp_vrf.py
FDK_TOPOTEST_TARGET=bgp_srv6l3vpn_to_bgp_vrf/test_bgp_srv6l3vpn_to_bgp_vrf.py
FDK_TOPOTEST_TARGET=srv6_locator/test_srv6_locator.py
FDK_TOPOTEST_TARGETS="\
	bgp_multi_vrf_topo1/test_bgp_multi_vrf_topo1.py
	bgp-vrf-route-leak-basic/test_bgp-vrf-route-leak-basic.py
	bgp_instance_del_test/test_bgp_instance_del_test.py
	bgp_prefix_sid2/test_bgp_prefix_sid2.py
	bgp_srv6l3vpn_to_bgp_vrf/test_bgp_srv6l3vpn_to_bgp_vrf.py
	"
FDK_TOPOTEST_TARGETS="\
	zebra_seg6_route/test_zebra_seg6_route.py
	zebra_seg6local_route/test_zebra_seg6local_route.py
  srv6_locator/test_srv6_locator.py
	bgp_prefix_sid2/test_bgp_prefix_sid2.py
	bgp_srv6l3vpn_to_bgp_vrf/test_bgp_srv6l3vpn_to_bgp_vrf.py
	"

alias cdf="cd $FDK_FRR_PATH"
alias cdt="cd $FDK_FRR_PATH/tests/topotests/"
alias vifdk='vim ~/git/fdk/bin/fdk-local.bash && source ~/git/fdk/bin/fdk-local.bash'
alias fdk-push='cd ~/git/fdk && git add . && git commit -m update && git push'
alias vifdk-test-target="vim $FDK_FRR_PATH/tests/topotests/$FDK_TOPOTEST_TARGET"

function c() {
	cd $FDK_FRR_PATH
	make clean
	./bootstrap.sh
	./configure \
    --prefix=/usr \
    --includedir=\${prefix}/include \
    --enable-exampledir=\${prefix}/share/doc/frr/examples \
    --bindir=\${prefix}/bin \
    --sbindir=\${prefix}/lib/frr \
    --libdir=\${prefix}/lib/frr \
    --libexecdir=\${prefix}/lib/frr \
    --localstatedir=/var/run/frr \
    --sysconfdir=/etc/frr \
    --with-moduledir=\${prefix}/lib/frr/modules \
    --with-libyang-pluginsdir=\${prefix}/lib/frr/libyang_plugins \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-snmp=agentx \
    --enable-multipath=64 \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --with-pkg-git-version \
    --with-pkg-extra-version=-MyOwnFRRVersion \
    --enable-sharpd \
		--enable-doc-html \
		#end
}

function cb() {
	cd $FDK_FRR_PATH
	./bootstrap.sh
	./configure \
    --prefix=/usr \
    --includedir=\${prefix}/include \
    --enable-exampledir=\${prefix}/share/doc/frr/examples \
    --bindir=\${prefix}/bin \
    --sbindir=\${prefix}/lib/frr \
    --libdir=\${prefix}/lib/frr \
    --libexecdir=\${prefix}/lib/frr \
    --localstatedir=/var/run/frr \
    --sysconfdir=/etc/frr \
    --with-moduledir=\${prefix}/lib/frr/modules \
    --with-libyang-pluginsdir=\${prefix}/lib/frr/libyang_plugins \
    --enable-configfile-mask=0640 \
    --enable-logfile-mask=0640 \
    --enable-snmp=agentx \
    --enable-multipath=64 \
    --enable-user=frr \
    --enable-group=frr \
    --enable-vty-group=frrvty \
    --with-pkg-git-version \
    --with-pkg-extra-version=-MyOwnFRRVersion \
    --enable-sharpd \
		--enable-doc-html \
		#end
	make clean && make -C $FDK_FRR_PATH -j16 && make -C $FDK_FRR_PATH -j16 install
}

function ta() {
	echo fdk-test-all
}

function fdk-test-list() {
	for file in $FDK_TOPOTEST_TARGETS; do
		echo $file;
	done
}

function fdk-test-all() {
	for file in $FDK_TOPOTEST_TARGETS; do
		pytest -s -v --log-level=DEBUG $FDK_FRR_PATH/tests/topotests/$file;
	done
}

function fdk-test-one() { pytest -s -vv --log-level=DEBUG $FDK_FRR_PATH/tests/topotests/$FDK_TOPOTEST_TARGET; }
function t() { echo fdk-test-one; }

function fdk-test-one-topology-only() { pytest -s -v --log-level=DEBUG --topology-only $FDK_FRR_PATH/tests/topotests/$FDK_TOPOTEST_TARGET; }
function tt() { echo fdk-test-one-topology-only; }

function l() { ps aux | grep mininet | grep -v grep | awk '{ print $14 }' | awk -F: '{ print $2 }'; }
function b() { make -C $FDK_FRR_PATH -j16 && make -C $FDK_FRR_PATH -j16 install; }
function cbtt() { cb && tt; }
function bt() { b && t; }
function bta() { b && ta; }
function btt() { b && tt; }

function r1p() { echo $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}'); }
function r2p() { echo $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}'); }

function r1()  { nsenter -a -t $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}') bash --norc; }
function r2()  { nsenter -a -t $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}') bash --norc; }
function r3()  { nsenter -a -t $(ps aux | grep mininet:r3 | grep -v grep | awk '{print $2}') bash --norc; }
function r1v() { nsenter -a -t $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}') vtysh ; }
function r2v() { nsenter -a -t $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}') vtysh ; }

function ce1() { nsenter -a -t `ps aux | grep mininet:ce1 | grep -v grep | awk '{print $2}'` bash --norc; }
function ce2() { nsenter -a -t `ps aux | grep mininet:ce2 | grep -v grep | awk '{print $2}'` bash --norc; }
function ce3() { nsenter -a -t `ps aux | grep mininet:ce3 | grep -v grep | awk '{print $2}'` bash --norc; }
function ce4() { nsenter -a -t `ps aux | grep mininet:ce4 | grep -v grep | awk '{print $2}'` bash --norc; }
function ce5() { nsenter -a -t `ps aux | grep mininet:ce5 | grep -v grep | awk '{print $2}'` bash --norc; }
function ce6() { nsenter -a -t `ps aux | grep mininet:ce6 | grep -v grep | awk '{print $2}'` bash --norc; }

function fdk-list() { l; }

function fdk-enter() {
  if [ $# -lt 1 ]; then
    echo "invalid command syntax" 1>&2
    echo "Usage: $0 <mininet-node>" 1>&2
    return 1
	fi

  PID=$(pgrep -f "bash --norc -is mininet:$1")
	if [ $# -eq 1 ]; then
		nsenter -t $PID -a bash --norc
	else
		nsenter -t $PID -a "${@:2:($#-1)}"
	fi
}

function _fdk-enter() {
  local args
  case $COMP_CWORD in
  1) args=$(l ${COMP_WORDS[1]}) ;;
  esac

  COMPREPLY=( `compgen -W "$args" -- ${COMP_WORDS[COMP_CWORD]}` )
}

complete -F _fdk-enter fdk-enter
