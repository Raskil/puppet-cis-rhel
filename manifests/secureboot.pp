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
  $grubpassword_manage        = $cisbench::params::grubpassword_manage,
  $singleusermodelogin_report = $cisbench::params::singleusermodelogin_report,
  $singleusermodelogin_manage = $cisbench::params::singleusermodelogin_manage,
  $nointeractiveboot_report   = $cisbench::params::nointeractiveboot_report,
  $nointeractiveboot_manage   = $cisbench::params::nointeractiveboot_manage,) inherits cisbench::params {
  validate_bool($grubconfownedbyroot_manage)
  validate_bool($grubconfownedbyroot_report)
  validate_bool($grubconfnoaccess_manage)
  validate_bool($grubconfnoaccess_report)
  validate_bool($grubpassword_report)
  validate_bool($grubpassword_manage)
  validate_string($grubpassword)
  validate_bool($singleusermodelogin_report)
  validate_bool($singleusermodelogin_manage)
  validate_bool($nointeractiveboot_report)
  validate_bool($nointeractiveboot_manage)

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
    fail('Cisbench Module: You set $grubpassword_manage to true but did not supply a password to $cisbench::secureboot. Please supply an SHA-512 encrypted grub password via parameter $cisbench::secureboot::grubpassword or set $cisbench::secureboot::grubpassword_manage to false.'
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
      onlyif  => "match password size == 0",
    }
  }

  if $::cis['has_grubpassword'] == false and $grubpassword_report == true {
    notify { 'Cisbench: Grub config file has no password set!': }
  }

  if $::cis['has_singleusermodelogin'] == false and $singleusermodelogin_report == true {
    notify { 'Cisbench: Single User Mode has a non login shell configured!': }
  }

  if $singleusermodelogin_manage == true {
    $loginshell = '/sbin/sulogin'
  } else {
    $loginshell = '/sbin/sushell'
  }

  if $nointeractiveboot_manage == true {
    $prompt = 'no'
  } else {
    $prompt = 'yes'
  }

  if $singleusermodelogin_manage == true or $nointeractiveboot_manage == true {
    file { '/etc/sysconfig/init':
      ensure  => 'file',
      content => template('cisbench/init.erb'),
      group   => 'root',
      mode    => '0644',
      owner   => 'root',
    }
  }

}
