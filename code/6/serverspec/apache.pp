package {'httpd':
  ensure => true,
  enable => true,
}
service {'httpd':
  ensure  => true,
  enable  => true,
  require => Package['httpd'],
}
