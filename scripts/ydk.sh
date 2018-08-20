# Essentials
echo "Installing Java.."
sudo apt-get -y -q install default-jdk
echo "Updating packages.."
sudo apt-get -y -q update

echo "Updating pip.."
sudo pip install -U -q pip
echo "Installing kafka-python module.."
sudo pip install -q kafka-python

# Add route supernet for networks in use by IOS-XR topology without breaking internet default route.
echo "Add route to virtual router networks.."
sudo route add -net 10.0.0.0/8 gw 10.1.1.1

# Get, configure, and run pipeline
echo "Get, configure, and run pipeline.."
mkdir /vagrant/pipeline
git clone -q https://github.com/cisco/bigmuddy-network-telemetry-pipeline.git /vagrant/pipeline
/vagrant/pipeline/bin/pipeline -config /vagrant/init-configs/pipeline.conf -log /vagrant/pipeline/pipeline.log 2> /dev/null &

# Get, configure, and run kafka
echo "Get, configure, and run kafka/zookeeper.."
wget -q http://apache.claz.org/kafka/2.0.0/kafka_2.11-2.0.0.tgz
mkdir /vagrant/kafka
tar -xzf kafka_2.11-2.0.0.tgz -C /vagrant/kafka
mv /vagrant/kafka/kafka_2.11-2.0.0/* /vagrant/kafka/ 
/vagrant/kafka/bin/zookeeper-server-start.sh /vagrant/kafka/config/zookeeper.properties 2> /dev/null &
/vagrant/kafka/bin/kafka-server-start.sh /vagrant/kafka/config/server.properties 2> /dev/null &
