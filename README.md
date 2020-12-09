# FDK: FRR Development Kit

install
```
git clone https://github.com/slankdev/FDK ~/git/fdk
source ~/git/fdk/bin/fdk.bash
```

topotest
```
FDK_TOPOTEST_DIR=srv6_manager
FDK_TOPOTEST_FILE=test_srv6_manager.py
fdk-topotest container --topology-only
```
