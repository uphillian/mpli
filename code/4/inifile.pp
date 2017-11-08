ini_setting {'puppet-server':
  section => 'main',
  path    => '/home/thomas/.puppet/puppet.conf',
  setting => 'server',
  value   => 'puppet.mpli.packtpub.com',
}

ini_subsetting {'puppet-reports-store':
  section           => 'agent',
  path              => '/home/thomas/.puppet/puppet.conf',
  setting           => 'reports',
  subsetting_separator => ',',
  subsetting        => 'store',
}

ini_subsetting {'puppet-reports-logstash':
  section           => 'agent',
  path              => '/home/thomas/.puppet/puppet.conf',
  setting           => 'reports',
  subsetting_separator => ',',
  subsetting        => 'logstash',
}

