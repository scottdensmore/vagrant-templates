# -*- mode: ruby -*-
# vi: set ft=ruby :

def configure_vagrant_machine(hostname, vm, cpus, memory)
  is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

  vm.box = 'bento/ubuntu-16.04'
  vm.hostname = hostname

  vm.provider 'virtualbox' do |vb, override|
    # NAT settings so network isn't super slow
    override.vm.network :private_network, ip: "192.168.100.50"
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.cpus = cpus
    vb.memory = memory
    vb.name = "vagrant-#{hostname}"

    if is_windows
      override.vm.synced_folder ".", "/vagrant", mount_options: ["fmode=700"]
    end
  end

  vm.provider 'parallels' do |prl, override|
    override.vm.network :private_network, ip: "192.168.100.50"
    prl.update_guest_tools = true
    prl.optimize_power_consumption = false
    prl.cpus = cpus
    prl.memory = memory
    prl.name = "vagrant-#{hostname}"
  end
end

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.ssh.forward_agent = true
  
  # configure your virtual machine
  configure_vagrant_machine('service', config.vm, 4, 4096)
  # These are executed as 'inline' scripts so that they can refer to relative paths within the /vagrant folder.
  config.vm.provision 'shell', inline: '/bin/bash /vagrant/vagrant_scripts/provision-system.sh'
  config.vm.provision 'shell', inline: '/bin/bash /vagrant/vagrant_scripts/provision-profile.sh', run: 'always'
  # For rsync when IDEs wants to use your public key for this since we don't know anything about the key Vagrant uses
  ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
  config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false
  # Add any specific keys like github.com so if you do this in startup it works
  config.vm.provision 'shell', inline: '/bin/bash /vagrant/vagrant_scripts/provision-keys.sh', privileged: false
  # Add any other custom scripts

end
