#!/bin/bash
## This script is only used by Vagrant for making our environment available
## with the right hostname resolutions and pre-downloads PE to share across
## the instances.  It's not used outside of Vagrant.
## Yeah, it's a BASH script. So what? Tool for the job, yo.

## The version of PE to make available to in our Vagrant environment
PE_VERSION="2016.2.1"

###########################################################
ANSWERS=$1
PE_URL="https://s3.amazonaws.com/pe-builds/released/${PE_VERSION}/puppet-enterprise-${PE_VERSION}-el-7-x86_64.tar.gz"
FILENAME=${PE_URL##*/}
DIRNAME=${FILENAME%*.tar.gz}
PE_INSTALLER="bootstrap/pe"

## A reasonable PATH
echo "export PATH=$PATH:/usr/local/bin:/opt/puppet/bin" >> /etc/bashrc

## Add host entries for each system
cat > /etc/hosts <<EOH
127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain
::1 localhost localhost.localdomain localhost6 localhost6.localdomain
###############################################################################
192.168.1.7 master.vagrant.vm master
192.168.1.9 agent1.vagrant.vm agent1
192.168.1.10 agent2.vagrant.vm agent1

###############################################################################
## CNAMEs for CA server
192.168.1.7 puppetca.vagrant.vm puppetca puppet.vagrant.vm puppet

EOH

systemctl disable firewalld
systemctl stop firewalld

## Download and extract the PE installer
cd /vagrant/puppet/pe || (echo "/vagrant/puppet/pe doesn't exist." && exit 1)
if [ ! -f $FILENAME ]; then
  curl -O ${PE_URL} || (echo "Failed to download ${PE_URL}" && exit 1)
else
  echo "${FILENAME} already present"
fi

if [ ! -d ${DIRNAME} ]; then
  tar zxf ${FILENAME} || (echo "Failed to extract ${FILENAME}" && exit 1)
else
  echo "${DIRNAME} already present"
fi

## Bootstrap the master(s)
if [[ "$1" == *master.txt ]]; then
  yum install -y git
fi
