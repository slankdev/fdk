
function cb() {
	C=/home/ubuntu/frr.tmp
	cd $C
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
		--enable-lttng \
		# --enable-werror \
		# --enable-address-sanitizer \
		# --enable-thread-sanitizer \
		# --enable-memory-sanitizer \
		#end
	make clean && make -C $C -j16 && make -C $C -j16 install
}

function cb-no-rfapi() {
	C=/home/ubuntu/frr.tmp
	cd $C
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
    --disable-bgp-vnc \
		--enable-lttng \
		# --enable-werror \
		# --enable-address-sanitizer \
		# --enable-thread-sanitizer \
		# --enable-memory-sanitizer \
		#end
	make clean && make -C $C -j16 && make -C $C -j16 install
}

function b() {
	C=/home/ubuntu/frr.tmp
  make -C $C -j16 && make -C $C -j16 install
}

function t() {
	C=/home/ubuntu/frr.tmp
	cd $C/tests/topotests/bgp_srv6l3vpn_to_bgp_vrf
	test_bgp_srv6l3vpn_to_bgp_vrf.py
}

function tt() {
	C=/home/ubuntu/frr.tmp
	cd $C/tests/topotests/bgp_srv6l3vpn_to_bgp_vrf
	test_bgp_srv6l3vpn_to_bgp_vrf.py --topology-only
}

function cbtt() {
	cb && tt
}

function cb-no-rfapi-tt() {
	cb-no-rfapi && tt
}

function bt() {
	b && t
}

function btt() {
	b && tt
}

function r1p() {
  echo $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}')
}

function r1() {
	if [ $# -ne 0 ]; then
		nsenter -a -t $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}') $*
	else
		nsenter -a -t $(ps aux | grep mininet:r1 | grep -v grep | awk '{print $2}') vtysh
	fi
}

function r2p() {
  echo $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}')
}

function r2() {
	if [ $# -ne 0 ]; then
		nsenter -a -t $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}') $*
	else
		nsenter -a -t $(ps aux | grep mininet:r2 | grep -v grep | awk '{print $2}') vtysh
	fi
}

alias cdt='cd ~/frr.tmp/tests/topotests/bgp_srv6l3vpn*'
alias vifdk='vim ~/git/fdk/bin/fdk-local.bash && source ~/git/fdk/bin/fdk-local.bash'
