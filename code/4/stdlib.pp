
file_line {'no root login':
  ensure => present,
  line   => 'PermitRootLogin no',
  match  => '^PermitRootLogin\s+',
  path   => '/tmp/etc/ssh/sshd_config',
}
file_line {'nothing':
  ensure            => absent,
  match             => "^Port.*$",
  line              => 'Port',
  path              => '/tmp/etc/ssh/sshd_config',
  match_for_absence => true,
  multiple          => true,
  replace           => false,
}

