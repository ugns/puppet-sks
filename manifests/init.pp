# == Class: sks
#
# Full description of class sks here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class sks (
  $version    = $sks::params::version,
  $membership = undef,
) inherits sks::params {

  # validate parameters here

  class { 'sks::install': } ->
  class { 'sks::config': } ~>
  class { 'sks::service': } ->
  Class['sks']
}
