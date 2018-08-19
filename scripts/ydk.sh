# Essentials
sudo apt-get -y update
sudo apt-get -y install default-jdk

sudo pip install kafka-python

# Add route supernet for networks in use by IOS-XR topology without breaking internet default route.
sudo route add -net 10.0.0.0/8 gw 10.1.1.1

# Get, configure, and run pipeline
mkdir /vagrant/pipeline
git clone https://github.com/cisco/bigmuddy-network-telemetry-pipeline.git /vagrant/pipeline
/vagrant/pipeline/bin/pipeline -config /vagrant/init-configs/pipeline.conf -log /vagrant/pipeline/pipeline.log 2> /dev/null &

# Get, configure, and run kafka
wget http://apache.claz.org/kafka/2.0.0/kafka_2.11-2.0.0.tgz
mkdir /vagrant/kafka
tar -xzf kafka_2.11-2.0.0.tgz -C /vagrant/kafka
mv /vagrant/kafka/kafka_2.11-2.0.0/* /vagrant/kafka/ 
/vagrant/kafka/bin/zookeeper-server-start.sh /vagrant/kafka/config/zookeeper.properties 2> /dev/null &
/vagrant/kafka/bin/kafka-server-start.sh /vagrant/kafka/config/server.properties 2> /dev/null &
