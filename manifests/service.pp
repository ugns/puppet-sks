# == Class sks::service
#
# This class is meant to be called from sks
# It ensure the service is running
#
class sks::service {
  include sks::params

  service { $sks::params::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => false,
    hasrestart => true,
  }
}
