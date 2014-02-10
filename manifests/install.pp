# == Class sks::install
#
class sks::install {
  include sks::params

  package { $sks::params::package_name:
    ensure => present,
  }
}
