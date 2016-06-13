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
class cisbench::selinux (
  $selinuxgrubenabled_report = $cisbench::params::selinuxgrubenabled_report,
  $selinuxgrubenabled_manage = $cisbench::params::selinuxgrubenabled_manage,) inherits cisbench::params {
  if $::cis['is_selinuxbootenabled'] == false and $selinuxgrubenabled_report == true {
    notify { 'Cisbench: Selinux is disabled in Grub Boot Config!': }
  }

  if $selinuxgrubenabled_manage == true {
    kernel_parameter { "selinux=0": ensure => absent, }
  }

}
