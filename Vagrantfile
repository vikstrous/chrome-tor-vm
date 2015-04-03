# -*- mode: ruby -*-
# vi: set ft=ruby :

# USAGE:
# vagrant up
# vagrant ssh
# python /vagrant/server/webserver/webserver.py

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  config.ssh.forward_x11 = true
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "2048"]
  end

#  config.ssh.private_key_path = "~/.ssh/id_rsa"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  #config.vm.network "forwarded_port", guest: 9074, host: 9074

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "shared", "/vagrant"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "file", source: "sources.list", destination: "/tmp/sources.list"
  config.vm.provision "file", source: "dhclient.conf", destination: "/tmp/dhclient.conf"

  config.vm.provision "shell", inline: <<-SHELL
    cp /tmp/sources.list /etc/apt/sources.list
    cp /tmp/dhclient.conf /etc/dhcp/dhclient.conf
    apt-get update
    apt-get install -y chromium-browser tor
    apt-get install -y pepperflashplugin-nonfree 2>/dev/null
  SHELL

  config.vm.provision "file", source: "torrc", destination: "/tmp/torrc"
  config.vm.provision "file", source: "iptables.rules", destination: "/tmp/iptables.rules"
  config.vm.provision "file", source: "iptables", destination: "/tmp/iptables"
  config.vm.provision "shell", inline: <<-SHELL
    cp /tmp/torrc /etc/tor/torrc
    service tor restart
    cp /tmp/iptables.rules /etc/iptables.rules
    cp /tmp/iptables /etc/network/if-pre-up.d/iptables
    chmod +x /etc/network/if-pre-up.d/iptables
#/etc/network/if-pre-up.d/iptables
  SHELL

  # clear the history and turn it off, runs always
  config.vm.provision "shell", inline: <<-SHELL, run: "always"
    rm -rf /home/vagrant/.config
    mkdir -p /home/vagrant/.config/chromium/Default/
    chown -R vagrant:vagrant /home/vagrant/.config/
  SHELL
  config.vm.provision "file", source: "History", destination: "/home/vagrant/.config/chromium/Default/History", run: "always"
  config.vm.provision "shell", inline: <<-SHELL, run: "always"
    chown -R vagrant:vagrant /home/vagrant/.config/
    chmod -w /home/vagrant/.config/chromium/Default/History
  SHELL
 end
