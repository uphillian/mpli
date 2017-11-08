concat {'bashrc':
  path => '/tmp/etc/bashrc',
}

$local = @(LOCAL/L)
    export PATH=$PATH:/usr/local/bin:/usr/local/sbin
    | LOCAL

concat::fragment {'local':
  target  => 'bashrc',
  order   => '001',
  content => $local,
}

$umask = @(UMASK/L)
    if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
      umask 002
    else
      umask 022
    fi
    | UMASK

concat::fragment {'umask':
  target  => 'bashrc',
  order   => '002',
  content => $umask,
}

