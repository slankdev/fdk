
# VM setup

centos7 is expected
```
yum install -y ansible python3
ansible-playbook main.yml
```

files
- `/var/lib/libvirt/images/cloud-ubuntu-1804-amd64.img`
- `/var/lib/libvirt/images/base-ubuntu-1804-amd64-cidata.iso`
- `/var/lib/libvirt/images/ubuntu-1804-amd64.iso`

references:
- latest iproute2 https://qiita.com/ebiken/items/fc86b054b76442e495f1
- https://medium.com/@art.vasilyev/use-ubuntu-cloud-image-with-kvm-1f28c19f82f8
