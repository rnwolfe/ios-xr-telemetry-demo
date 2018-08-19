# Cisco IOS-XR Streaming Telemetry Demo Environment
## Prerequisites
Vagrant
Virtual Box
Cisco IOS-XRv Vagrant box (provide link)

## Initializing

```
git clone <this repo>
vagrant up
```

## Then what
Get into YDK box:

```
vagrant ssh ydk


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

