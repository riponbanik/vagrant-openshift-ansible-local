# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  # config.vm.box_check_update = true 
  
  # Enable Password Auth
  # config.ssh.username = 'vagrant'
  # config.ssh.password = 'vagrant'
  config.vm.provision "shell", inline: <<-EOC
    sudo sed -i -e "\\#PasswordAuthentication no# s#PasswordAuthentication no#PasswordAuthentication yes#g" /etc/ssh/sshd_config
    sudo service sshd restart       
  EOC

  config.landrush.enabled = true # enabled hostname resolution
  
  # Enable own private key
  # config.ssh.insert_key = false
  # config.ssh.private_key_path = [ '~/.ssh/id_rsa' ]
  # config.vm.provision "file", source: '~/.ssh/id_rsa.pub', destination: '~/.ssh/authorized_key'
  # config.vm.provision "shell", inline: <<-EOC
  #   sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
  #   sudo service sshd restart
  # EOC
    
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    vb.cpus = 1
  end

  config.vm.define "node1" do |machine|
    machine.vm.network "private_network", ip: "192.168.56.41"

    config.vm.hostname = "osm-node1.lab.local"

    config.landrush.host 'osm-master.lab.local', '192.168.56.40'
    config.landrush.host 'osm-node2.lab.local', '192.168.56.42'

  end

  config.vm.define "node2" do |machine|
    machine.vm.network "private_network", ip: "192.168.56.42"
    config.vm.hostname = "osm-node2.lab.local"

    config.landrush.host 'osm-master.lab.local', '192.168.56.40'
    config.landrush.host 'osm-node1.lab.local', '192.168.56.41'
  end

  config.vm.define 'controller' do |machine|
    machine.vm.network "private_network", ip: "192.168.56.40"

    config.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 2
    end

    config.vm.hostname = "osm-master.lab.local"

    config.landrush.host 'osm-node1.lab.local', '192.168.56.41'
    config.landrush.host 'osm-node2.lab.local', '192.168.56.42'

    config.vm.provision "shell", inline: <<-SHELL
      sudo yum -y install git
      sudo yum -y install sshpass
      if [ ! -d /tmp/openshift-ansible ] ; then
        git clone https://github.com/openshift/openshift-ansible.git /tmp/openshift-ansible    
      fi  
    SHELL

    config.vm.provision :ansible_local do |ansible|
      ansible.playbook       = "playbook.yml"
      ansible.verbose        = true
      ansible.install        = true
      ansible.install_mode = "pip"
      ansible.version = "2.4.3.0"
      ansible.become = true
      ansible.become_user = "vagrant"      
      ansible.limit          = "all" # or only "nodes" group, etc.
      ansible.inventory_path = "inventory"
    end 
  end
end