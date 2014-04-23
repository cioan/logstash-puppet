#! /bin/bash

if [ -z "$1" ]
then
  echo "You need to provide the environment to install in:"
  echo "./install.sh ENVIRONMENT"
  echo "ENVIRONMENT can be local|test|malawitest|zanmi"
  exit 1
fi

apt-get update

# hack to make sure we have ruby1.9 installed instead of ruby1.8
apt-get remove ruby1.8
apt-get install -y ruby1.9.1 ruby1.9.1-dev rubygems1.9.1 irb1.9.1 ri1.9.1 \
build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev

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

