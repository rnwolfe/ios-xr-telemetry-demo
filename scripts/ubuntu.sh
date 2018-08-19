sudo apt-get update
sudo apt-get install -y traceroute python-setuptools python-dev build-essential git libssl-dev libffi-dev sshpass lxc
sudo easy_install pip
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python


sudo pip install enum34 idna ipaddress pycparser ansible 

sudo route add -net 10.0.0.0/8 gw 10.1.1.1

