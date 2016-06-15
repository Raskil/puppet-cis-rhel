# Class: cisbench::processhardening
#
# This module manages cisbench processhardening config
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cisbench::processhardening (
  $coredumpdisabled_report  = $cisbench::params::coredumpdisabled_report,
  $coredumpdisabled_manage  = $cisbench::params::coredumpdisabled_manage,
  $suiddumpdisabled_report  = $cisbench::params::suiddumpdisabled_report,
  $suiddumpdisabled_manage  = $cisbench::params::suiddumpdisabled_manage,
  $execshieldenabled_report = $cisbench::params::execshieldenabled_report,
  $execshieldenabled_manage = $cisbench::params::execshieldenabled_manage,) inherits cisbench::params {
  validate_bool($coredumpdisabled_report)
  validate_bool($coredumpdisabled_manage)
  validate_bool($suiddumpdisabled_report)
  validate_bool($suiddumpdisabled_manage)
  validate_bool($execshieldenabled_report)
  validate_bool($execshieldenabled_manage)

  if $::cis['is_coredumpdisabled'] == false and $coredumpdisabled_report == true {
    notify { 'Cisbench: Core dumps are enabled in limits.conf!': }
  }

  if $coredumpdisabled_manage == true {
    file { '/etc/security/limits.d/cis.conf':
      ensure  => 'file',
      content => template('cisbench/limits_cis.conf.erb'),
      group   => 'root',
      mode    => '0644',
      owner   => 'root',
    }
  }

  if $::cis['is_suiddumpdisabled'] == false and $suiddumpdisabled_report == true {
    notify { 'Cisbench: SUID Dumps are allowed in sysctl!': }
  }

  if $suiddumpdisabled_manage == true {
    sysctl { 'fs.suid_dumpable':
      ensure    => 'present',
      permanent => 'yes',
      value     => '0',
    }
  }

  if !('uek' in $::kernelrelease) {
    if $::cis['is_execshieldenabled'] == false and $execshieldenabled_report == true {
      notify { 'Cisbench: SUID Dumps are allowed in sysctl!': }
    }

    if $execshieldenabled_manage == true {
      sysctl { 'kernel.exec-shield':
        ensure    => 'present',
        permanent => 'yes',
        value     => '1',
      }
    }
  }

}
