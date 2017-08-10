# vagrant-pe-puppet
This will create a vagrant environment with a monolithic Puppet master, a CentOS 7 agent node and an Ubuntu 16 agent node.

You may need to edit vagrant.yml and provision.sh change the IPs to match your network.

If you want to access your nodes using the FQDN you will need to add the following to your host file.
```
192.168.1.7 master.vagrant.vm
192.168.1.9 agent1.vagrant.vm
192.168.1.10 agent2.vagrant.vm
```

Note: Images are subject to change as they get updated. You can go to https://app.vagrantup.com/puppetlabs if the images used no longer work. Also the environment requires a computer with at least 8 gigs of memory.

## Bring up the environments:
```
vagrant up
```

## Accessing the Master:
Run this command to ssh into your Puppet Master node.
```
vagrant ssh master
```

The PE installer is located in /vagrant/puppet/pe on the master. This is a mapped to your local file system so if you need to destroy the environment you won't have to download the installer again.

### Installing Puppet

```
cd /vagrant/puppet/pe/puppet-enterprise-2016.2.1-el-7-x86_64
./puppet-enterprise-installer
```

## Accessing the CentOS 7 node:
Run this command to ssh into your CentOS 7 node.
```
vagrant ssh agent1
```

## Accessing the Ubuntu 16 node:
Run this command to ssh into your Ubuntu 16 node.
```
vagrant ssh agent2
```

## Cleanup:
You can destroy the environment by running the following command.
```
vagrant destroy -f
```
