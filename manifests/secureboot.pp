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
  $grubconfownedbyroot_report = $cisbench::params::grubconfownedbyroot_report,
  $grubconfownedbyroot_manage = $cisbench::params::grubconfownedbyroot_manage,
  $grubconfnoaccess_manage    = $cisbench::params::grubconfnoaccess_manage,
  $grubconfnoaccess_report    = $cisbench::params::grubconfnoaccess_report,) inherits cisbench::params {
  validate_bool($grubconfownedbyroot_manage)
  validate_bool($grubconfownedbyroot_report)
  validate_bool($grubconfnoaccess_manage)
  validate_bool($grubconfnoaccess_report)

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

}
