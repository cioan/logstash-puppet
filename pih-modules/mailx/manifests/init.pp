class mailx {
	
	package { 'msmtp':
		ensure => installed,
	}

	package { 'mailutils':
		ensure => installed,
	}

	package { 'bsd-mailx':
		ensure => installed,
	}

	exec { 'msmtp info':
	    command     => 'msmtp --serverinfo --host=smtp.gmail.com --tls=on --tls-certcheck=off',
	    user		=> 'root',
	    subscribe   => [ Package['msmtp'], Package['mailutils'], Package['bsd-mailx'] ]
  	}
}