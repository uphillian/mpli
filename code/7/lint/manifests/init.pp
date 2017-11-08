# any comment will do
class lint {
  file {'/tmp/lint':
    something => 'something',
    another => 'not lined up',
    ensure => true,
    long      => 'a long line is not a great thing, especially if it\'s more than 80 chars'
  }
  notify { "nothing": }
}
