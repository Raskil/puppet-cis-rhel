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
class cisbench::aide (
  $aideinstalled_report = $cisbench::params::aideinstalled_report,
  $aideinstalled_manage = $cisbench::params::aideinstalled_manage,
  $aidedbpath           = $cisbench::params::aidedbpath,) inherits cisbench::params {
  if $::cis['is_aideinstalled'] == false and $aideinstalled_report == true {
    notify { 'Cisbench: AIDE Intrusion Detection Environment is not installed on your system!': }
  }

  if $aideinstalled_manage == true {
    validate_absolute_path($aidedbpath)

    package { 'aide': ensure => 'installed', }

    exec { 'Init Aide':
      command => "/usr/sbin/aide --init -B '${aidedbpath}'",
      user    => 'root',
      creates => $aidedbpath,
      require => Package['aide'],
    }
  }
}
