#! /bin/bash

if [ -z "$1" ]
then
  echo "You need to provide the environment to install in:"
  echo "./install.sh ENVIRONMENT"
  echo "ENVIRONMENT can be local|test|malawitest|zanmi"
  exit 1
fi

apt-get update
# on ubuntu 10.04 we need to install puppet 1.9.3 via RubyVersionManager
# \curl -sSL https://get.rvm.io | bash -s stable
# source /etc/profile.d/rvm.sh
# rvm version

# apt-get install libtool
# rvm pkg install libyaml
# rvm reinstall 1.9.3

gem install bundler --no-ri --no-rdoc

bundle

librarian-puppet install

echo "modulepath = /etc/puppet/modules:/etc/puppet/pih-modules" > puppet.conf
echo "environment = $1" >> puppet.conf

# puppet apply -v --detailed-exitcodes --logdest=console --logdest=syslog manifests/site.pp
puppet apply -v \
  --detailed-exitcodes \
  --logdest=console \
  --logdest=syslog \
  manifests/site.pp

