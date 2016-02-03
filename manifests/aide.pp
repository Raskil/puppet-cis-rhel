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
  $aidedbpath           = $cisbench::params::aidedbpath,
  $aidedbpath_out       = $cisbench::params::aidedbpath_out,
  $aideconf_path        = $cisbench::params::aideconf_path,) inherits cisbench::params {
  if $::cis['is_aideinstalled'] == false and $aideinstalled_report == true {
    notify { 'Cisbench: AIDE Intrusion Detection Environment is not installed on your system!': }
  }

  if $aideinstalled_manage == true {
    validate_absolute_path($aidedbpath)
    validate_absolute_path($aidedbpath_out)
    validate_absolute_path($aideconf_path)

    package { 'aide': ensure => 'installed', }

    exec { 'Init Aide':
      command => "/usr/sbin/aide --init --config '${aideconf_path}'",
      user    => 'root',
      creates => $aidedbpath,
      require => Package['aide'],
    }

    exec { 'Copy Aide New DB':
      command     => "/bin/cp ${aidedbpath_out}  ${aidedbpath}",
      user        => 'root',
      refreshonly => true,
      subscribe   => Exec['Init Aide'],
      before      => File[$aidedbpath],
    }

    file { $aidedbpath:
      owner    => 'root',
      group    => 'root',
      mode     => '0600',
      selrange => 's0',
      selrole  => 'object_r',
      seltype  => 'aide_db_t',
      seluser  => 'system_u',
    }
  }
}
