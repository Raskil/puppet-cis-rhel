# Class: cisbench::aide
#
# This module manages cisbench aide config
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cisbench::secureboot (
  $grubpassword               = undef,
  $grubconfownedbyroot_report = $cisbench::params::grubconfownedbyroot_report,
  $grubconfownedbyroot_manage = $cisbench::params::grubconfownedbyroot_manage,
  $grubconfnoaccess_manage    = $cisbench::params::grubconfnoaccess_manage,
  $grubconfnoaccess_report    = $cisbench::params::grubconfnoaccess_report,
  $grubpassword_report        = $cisbench::params::grubpassword_report,
  $grubpassword_manage        = $cisbench::params::grubpassword_manage,) inherits cisbench::params {
  validate_bool($grubconfownedbyroot_manage)
  validate_bool($grubconfownedbyroot_report)
  validate_bool($grubconfnoaccess_manage)
  validate_bool($grubconfnoaccess_report)
  validate_bool($grubpassword_report)
  validate_bool($grubpassword_manage)
  validate_string($grubpassword)

  if $::cis['is_grubconfownedbyroot'] == false and $grubconfownedbyroot_report == true {
    notify { 'Cisbench: Grub config file is not owned by root!': }
  }

  if $grubconfownedbyroot_manage == true or $grubconfnoaccess_manage == true {
    file { '/boot/grub/grub.conf':
      ensure => 'file',
      group  => 'root',
      mode   => '0600',
      owner  => 'root',
    }
  }

  if $::cis['has_grubconfnoaccess'] == false and $grubconfnoaccess_report == true {
    notify { 'Cisbench: Grub config file is accessible by other users than root!': }
  }

  if $grubpassword_manage == true and $grubpassword == undef {
    fail('Cisbench Module: You set $grubpassword_manage to true but did not supply a password to $cisbench::secureboot::grubpassword. Please supply an SHA-512 encrypted grub password via $cisbench::secureboot::grubpassword or set $cisbench::secureboot::grubpassword_manage to false.'
    )
  }

  if $grubpassword_manage == true and $grubpassword != undef {
    augeas { 'remove nonmatching pws':
      context => '/files/etc/grub.conf',
      changes => ['rm password'],
      onlyif  => "get password != $grubpassword",
    } ->
    augeas { 'Add SHA512 PW to Grub':
      context => "/files/etc/grub.conf",
      changes => [
        'ins password after timeout',
        'clear password/encrypted',
        "set password $grubpassword",
        ],
    }
  }

  if $::cis['has_grubpassword'] == false and $grubpassword_report == true {
    notify { 'Cisbench: Grub config file has no password set!': }
  }

}
