adminibar-cluster
-----------
Files for launching an adminibar cluster

Vagrant setup
-------------
1. install using guide: http://coreos.com/docs/running-coreos/platforms/vagrant/
2. expose docker api: http://coreos.com/docs/launching-containers/building/customizing-docker/#enable-the-remote-api-on-a-new-socket:

/etc/systemd/system/docker-tcp.socket:
```
[Unit]
Description=Docker Socket for the API

[Socket]
ListenStream=4243
Service=docker.service
BindIPv6Only=both

[Install]
WantedBy=sockets.target
```
execute
```
sudo systemctl enable docker-tcp.socket
sudo systemctl stop docker
sudo systemctl start docker-tcp.socket
sudo systemctl start docker
```

3. Configure ssh access https://github.com/coreos/fleet/blob/master/Documentation/remote-access.md:
`vagrant ssh-config | sed -n "s/IdentityFile//gp" | xargs ssh-add`


Stepshape HQ Setup (hq.stepshape.com:5000)
-------------
Single machine CoreOS setup that hosted by Vultr (https://my.vultr.com) that holds:
- private docker registry
- (future) ipxe server?
- (future) build server?

1. Host iPXE: https://coreos.com/docs/running-coreos/bare-metal/booting-with-ipxe:

(http://paste.ee/r/nTpD4)
```
#!ipxe

set base-url http://beta.release.core-os.net/amd64-usr/current
kernel ${base-url}/coreos_production_pxe.vmlinuz sshkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC891gFIU2UttRxPfVAXupJCKQCrnS2btQYWh3miMWNN9Iu5I6lzblwTVAq9eatvMyld8bdVG/BLZDLNDzN99g0gjK4xwwJN3Tc6DgX2xKCVoiN5YYwaiG4I30ugKesiOWmJKFoIu3RXjIfx0F5nat+CNlhxXmdF6ozWEFkaq1Pr29xmJzmd5kE8ZhPaqYNzp7dpJUtVE7oCuKoX4aFyKCAg/mdJtLYco8yYvIT+77DAAg3S/Jfev2rHOyVCimsHTOPVqMaLW2RK+nWtI4uNGE9aJFxqMV4gH70UmZR6DFNYWmcy11bGALBJgmrgMtLnUVoTmcMA8+UbaWnO0eBntsT advanderveer@Ads-MacBook-Pro.local"
initrd ${base-url}/coreos_production_pxe_image.cpio.gz
boot
```

2. Install to disk using the following user data (cloud config)

(http://paste.ee/r/QVKWp)
```
#cloud-config
users:
  - name: core
    coreos-ssh-import-github: advanderveer
```

`curl http://paste.ee/r/QVKWp > /tmp/userdata && sudo coreos-install -d /dev/vda -c /tmp/userdata`

3. Create custom configuration

(/etc/systemd/system/registry/conf.yml)
```
prod:
    loglevel: warn
    storage: s3
    s3_access_key: AKIAJXBRB2Y4THKCUCVQ
    s3_secret_key: 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
    s3_bucket: stepshape-registry
    boto_bucket: stepshape-registry
```

3. Install systemd unit/service

(/etc/systemd/system/registry.service)
```
[Unit]
Description=Docker Registry
Requires=docker.service
After=docker.service

[Service]
ExecStart=/usr/bin/docker run -p 5000:5000 -v /etc/systemd/system/registry:/registry-conf -e SETTINGS_FLAVOR=prod -e DOCKER_REGISTRY_CONFIG=/registry-conf/conf.yml registry

[Install]
WantedBy=multi-user.target
```
4. install and start:
`sudo systemctl enable /etc/systemd/system/registry.service`
`sudo systemctl start registry.service`

