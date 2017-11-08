class test {
  file {
    mode   => '0644',
    owner  => ['root','another'],
    group  => '0',
    ensure => 'directory',
}
