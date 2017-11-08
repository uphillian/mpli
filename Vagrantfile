# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # PuppetMaster
  config.vm.define "puppetca", primary: true do |puppet|
    #puppet.vm.box = "puppetmaster"
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppet.example.com"
    puppet.vm.network :forwarded_port, guest: 8140, host: 8140, id: "puppet"
    puppet.vm.network :private_network, ip: "192.168.50.100"
    puppet.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 1524
      v.cpus = 2
    end
    puppet.vm.synced_folder ".", "/vagrant", disabled: true
  end
  # PuppetMaster
  config.vm.define "puppetmaster1", primary: true do |puppet|
    #puppet.vm.box = "puppetmaster"
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppet.example.com"
    puppet.vm.network :private_network, ip: "192.168.50.201"
    puppet.vm.network :forwarded_port, guest: 22, host: 2223, id: "ssh"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
    puppet.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  end
  # PuppetMaster2
  config.vm.define "puppetmaster2", primary: true do |puppet|
    #puppet.vm.box = "puppetmaster"
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppet.example.com"
    puppet.vm.network :private_network, ip: "192.168.50.202"
    puppet.vm.network :forwarded_port, guest: 22, host: 2224, id: "ssh"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
    puppet.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  end
  # PuppetDB
  config.vm.define "puppetdb", primary: true do |puppet|
    puppet.vm.box = "centos/7"
    puppet.vm.hostname = "puppetdb.example.com"
    puppet.vm.network :private_network, ip: "192.168.50.101"
    puppet.vm.network :forwarded_port, guest: 22, host: 2225, id: "ssh"
    puppet.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 2
    end
    puppet.vm.synced_folder ".", "/home/vagrant/sync", disabled: true
  end

  # Example Node (mpli)
  config.vm.define "mpli" do |casit|
    casit.vm.box = "centos/7"
    casit.vm.hostname = "mpli.example.com"
    casit.vm.network :private_network, ip: "192.168.50.101"
    casit.vm.network :forwarded_port, guest: 22, host: 2226, id: "ssh"
    casit.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 2
    end
    casit.vm.synced_folder ".", "/vagrant", disabled: true
  end
  # Foreman
  config.vm.define "foreman" do |fm|
    fm.vm.box = "centos/7"
    fm.vm.hostname = "foreman.example.com"
    fm.vm.network :private_network, ip: "192.168.50.20"
    fm.vm.network :forwarded_port, guest: 22, host: 2520, id: "ssh"
    fm.vm.provider "virtualbox" do |v|
      v.memory = 1536
      v.cpus = 2
    end
  end
end
