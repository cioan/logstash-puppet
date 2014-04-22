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
}