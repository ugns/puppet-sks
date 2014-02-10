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
class sks (
  $version = present,
  $hostname = $::fqdn,
  $nodename = $::hostname,
  $server_contact = undef,
  $recon_address = undef,
  $recon_port = 11370,
  $hkp_address = undef,
  $hkp_port = 11371,
  $members = undef,
) inherits sks::params {

  # validate parameters here

  class { 'sks::install': } ->
  class { 'sks::config': } ~>
  class { 'sks::service': } ->
  Class['sks']
}
