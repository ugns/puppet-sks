# == Class: sks
#
# Full description of class sks here.
#
# === Parameters
#
# [*version*]
#   Version of SKS to install, defaults to 'present'
#
# [*hostname*]
#   Server hostname, defaults to $::fqdn
#
# [*nodename*]
#   Server nodename, defaults to $::hostname
#
# [*server_contact*]
#   Server contact Key ID to display on stats page
#
# [*recon_address*]
#   Recon address to bind
#
# [*recon_port*]
#   Recon port to listen on, defaults to 11370
#
# [*hkp_address*]
#   HKP address to bind
#
# [*hkp_port*]
#   HKP port to listen on, defaults to 11371
#
# [*members*]
#   Array of hashes containing SKS peers to add to the membership
#   file.
#   Supported hash entries include:
#     hostname: Hostname of SKS peer (required)
#     port:     SKS Recon port to connect to, Defaults to $sks::recon_port
#     admin:    SKS peer administrator's name (optional)
#     email:    SKS peer administrator's email address (optional)
#     keyid:    SKS peer administrator's Key ID (optional)
#
# [*initial_stat*]
#   Boolean to run database statistics on boot, Default is false
#
# [*disable_mailsync*]
#   Boolean to to disable mailsync, Default is false
#
# [*stat_hour*]
#   Hour to run database statistics on, Default is undef
#
# [*membership_reload_interval*]
#   Number of hours to reload membership file, Default is undef
#
# [*pagesize*]
#   bdb pagesize to use, Default is 16
#
# [*ptree_pagesize*]
#   bdb pagesize for PTree/ptree, Default is 16
#
# [*extra_options*]
#   Hash containing extra parameters to include in sksconf
#
class sks (
  $version                    = present,
  $hostname                   = $::fqdn,
  $nodename                   = $::hostname,
  $server_contact             = undef,
  $recon_address              = undef,
  $recon_port                 = 11370,
  $hkp_address                = undef,
  $hkp_port                   = 11371,
  $members                    = undef,
  $initial_stat               = false,
  $disable_mailsync           = false,
  $stat_hour                  = undef,
  $membership_reload_interval = undef,
  $pagesize                   = 16,
  $ptree_pagesize             = 16,
  $extra_options              = {},
) inherits sks::params {

  # validate parameters here

  class { 'sks::install': } ->
  class { 'sks::config': } ~>
  class { 'sks::service': } ->
  Class['sks']
}
