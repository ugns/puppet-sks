# == Class sks::params
#
# This class is meant to be called from sks
# It sets variables according to platform
#
class sks::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'sks'
      $service_name = 'sks'
    }
    'RedHat', 'Amazon': {
      $package_name = 'sks'
      $service_name = 'sks'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
