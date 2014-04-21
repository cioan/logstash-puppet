Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin/' ] }

node default {
  class { 'apt':
    always_apt_update => true,
  }

  include wget
  # include java
  # include logging
}

node 'env_test' inherits default {
	notify {"env_test node":}
	file {'testfile':
	  path    => '/tmp/testfile_env',
	  ensure  => present,
	  mode    => 0640,
	  content => "I'm a test environmet.",
	}
}