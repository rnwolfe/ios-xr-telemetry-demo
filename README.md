# Cisco IOS-XR Streaming Telemetry Demo Environment
## Prerequisites

* Vagrant
* Virtual Box
* Cisco IOS-XRv Vagrant box ([instructions](https://xrdocs.io/getting-started/iosxr-vagrant-beta))

## Initializing

```
git clone https://github.com/rnwolfe/ios-xr-telemetry-demo.git
vagrant up
```

This will take 10-15 minutes to run.

## Then what
Get into YDK box:

```
vagrant ssh ydk
```

Dump telemetry data in JSON directly from Kafka bus:

```
python /vagrant/script/consume-telemetry.py
```

Simple demo of performing logic with data from kafka (will show old/new bytes received value from two routers, but only if changed from previous):

```
python /vagrant/script/show-bytes-on-change.py
```

## Get into routers

```
vagrant port rtr1
```

Get port that is mapped to 22.

```
ssh vagrant@localhost -p 2223
```

Password is `vagrant`.

