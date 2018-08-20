# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|
	# YDK Python Tools box, telemetry receiver/handler
	config.vm.define "ydk", primary: true do |ydk|
	  ydk.vm.box = "ydk-py-ubuntu"
	  ydk.vm.box_url = "http://ydk.cisco.com/vagrant/ydk-py-ubuntu/"

	  # I raised the RAM because sometimes java wouldn't start kafka due to lack of free memory
	  config.vm.provider "virtualbox" do |v|
	    v.memory = 1024
	  end

	  ydk.vm.network :private_network, virtualbox__intnet: "link1", ip: "10.1.1.11"
	  ydk.vm.provision "file", source: "init-configs/pipeline.conf", destination: "/home/vagrant/pipeline/pipeline.conf"
	  ydk.vm.provision :shell, path: "scripts/ydk.sh", privileged: false
	end

    config.vm.define "rtr1" do |node|
      node.vm.box =  "IOS-XRv"
  	  node.vm.boot_timeout = 900

      # gig0/0/0/0 connected to link1, gig0/0/0/1 connected to link2, gig0/0/0/2 connected to link3, auto-config not supported.

      node.vm.network :private_network, virtualbox__intnet: "link1", auto_config: false
      node.vm.network :private_network, virtualbox__intnet: "link2", auto_config: false
      node.vm.network :private_network, virtualbox__intnet: "link3", auto_config: false 

	  # Source a config file and apply it to XR
	  node.vm.provision "file", source: "init-configs/rtr1_config", destination: "/home/vagrant/rtr1_config"

	  node.vm.provision "shell" do |s|
	      s.path =  "scripts/apply_config.sh"
	      s.args = ["/home/vagrant/rtr1_config"]
	  end

    end

    config.vm.define "rtr2" do |node|
      node.vm.box =  "IOS-XRv"
      node.vm.boot_timeout = 900

      # gig0/0/0/0 connected to link2, gig0/0/0/1 connected to link3, auto-config not supported
      node.vm.network :private_network, virtualbox__intnet: "link2", auto_config: false
      node.vm.network :private_network, virtualbox__intnet: "link3", auto_config: false

	  #Source a config file and apply it to XR
	  node.vm.provision "file", source: "init-configs/rtr2_config", destination: "/home/vagrant/rtr2_config"

	  node.vm.provision "shell" do |s|
	      s.path =  "scripts/apply_config.sh"
	      s.args = ["/home/vagrant/rtr2_config"]
	  end

    end

end
