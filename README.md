# frrdev
FRR Development Kit for CentOS-7 users

init script
```bash
#!/bin/sh
curl -L get.docker.com | sh
systemctl start docker
systemctl enable docker
```

After that, update kernel. and load `mpls_router` and `mpls_iptunnel`

## Setup Developement Env

Launch Development Container
```bash
> git clone this-repo && cd repo
> ./docker/build.sh
> ./docker/run.sh
```

Clone, Build and Install FRR
```bash
docker exec -it frr bash
git clone -b slankdev-zebra-srv6-manager https://github.com/slankdev/frr /root/frr && cd $_
./bootstrap.sh
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
    --with-pkg-extra-version=-slankdev-develop

make -j`nproc` && make install -j`nproc`
install -m 775 -o frr -g frr -d /var/log/frr
install -m 775 -o frr -g frrvty -d /etc/frr
install -m 640 -o frr -g frrvty tools/etc/frr/vtysh.conf /etc/frr/vtysh.conf
install -m 640 -o frr -g frr tools/etc/frr/frr.conf /etc/frr/frr.conf
install -m 640 -o frr -g frr tools/etc/frr/daemons.conf /etc/frr/daemons.conf
install -m 640 -o frr -g frr tools/etc/frr/daemons /etc/frr/daemons

addgroup --system --gid 92 frr
addgroup --system --gid 85 frrvty
adduser --system --ingroup frr --home /var/run/frr/ --gecos "FRRouting suite" --shell /bin/false frr
usermod -G frrvty frr
chown -R frr.frr /var/run/frr
```

## Execute Topotest
```
cd /root/frr/tests/topotest/srv6_manager
./test_srv6_manager.py --topology-only
```

```
nsenter -t $(pgrep -f mininet:r1) -a vtysh -c 'sh segment-routing srv6 sid'
Local SIDs:
 Name       Context              Prefix                   Owner
---------- -------------------- ------------------------ ------------
 End        USP                  2001:db8:1:1:1::/80      static
 End        USP                  2001:db8:2:2:1::/80      static
```
