# Vagrant Templates

A base template for building an Ubuntu 16.04 box plus some existing provisioning scripts.

The customization should be done in the Vagrantfile. Update the name of the machine, IP of the machine, and add any custom scripts you want to add a the end of the setup.

## Service Fabric

Provision a local instance of [Service Fabric](https://azure.microsoft.com/en-us/services/service-fabric/) on linux.
Once you have setup the vm you can see the Service Fabric UI at http://192.168.100.50:19080/Explorer/index.html#/apps.

## mongoDB

Provision an instance of [mongoDB](https://www.mongodb.com) on linux.
After provisioning, you will need to restart the machine to pick up changes.

```vagrant halt```

```vagrant up```

## swift

Provision Apple's [swift](https://swift.org) on linux.

## Vapor

Provision [Vapor](https://vapor.codes) on linux.

## Continuous integration

Static checks parse the Ruby Vagrantfile and every tracked Bash provisioning script with preinstalled tools. They do not evaluate the Vagrantfile, load Vagrant/plugins, boot a VM, fetch boxes, read SSH keys, run provisioning, download packages, or change system settings.

A passing check establishes syntax only. Ubuntu 16.04, the legacy package repositories and the provisioned services are not functionally validated; VM/provisioning modernization requires a separate approved environment. Existing scripts and configuration remain unchanged.
