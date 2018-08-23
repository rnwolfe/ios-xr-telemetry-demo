# Essentials
echo "Updating packages.."
sudo apt-get -y -q docker.io
sudo apt-get -y -q update

echo "Updating pip.."
sudo pip install -U -q pip
echo "Installing kafka-python module.."
sudo pip install -q kafka-python

# Add route supernet for networks in use by IOS-XR topology without breaking internet default route.
echo "Add route to virtual router networks.."

# Pull docker container
sudo docker pull akshshar/pipeline-kafka

# Run container instance with needed ports exposed and pushing our pipeline.conf file into it.
docker run -itd --name pk -v /vagrant/scripts/:/root/ -v /vagrant/init-configs/pipeline.conf:/data/pipeline.conf -p 5432:5432 -p 5958:5958 -p 9092:9092 -p 2181:2181 akshshar/pipeline-kafka

# Once on the VM, get on the container and run scripts using:
#   docker exec -it pk bash
#   cd /root
#   python show-bytes-on-change.py
#   python consume-telemetry.py
# 
# You could also run in background using something like:
#   python show-bytes-on-change.py > output.txt &