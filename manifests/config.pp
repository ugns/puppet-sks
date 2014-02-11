# == Class sks::config
#
# This class is called from sks
#
class sks::config {

  file { '/etc/sks/sksconf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('sks/sksconf.erb'),
  }

  file { '/etc/sks/membership':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('sks/membership.erb'),
  }
}
