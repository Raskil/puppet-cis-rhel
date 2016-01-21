# Class: cisbench
#
# This module manages cisbench
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cisbench::config_softwareupdates (
  $securityupdatesinstallled_report = $cisbench::params::securityupdatesinstallled_report,
  $oraclegpgkeyinstalled_report     = $cisbench::params::oraclegpgkeyinstalled_report,
  $oraclegpgkeyinstalled_manage     = $cisbench::params::oraclegpgkeyinstalled_manage,
  $yumgpgcheckenabled_report        = $cisbench::params::yumgpgcheckenabled_report,
  $yumgpgcheckenabled_manage        = $cisbench::params::yumgpgcheckenabled_manage,
  $yumconf_template                 = $cisbench::params::yumconf_template,
  $rhnsdenabled_report              = $cisbench::params::rhnsdenabled_report,
  $rhnsdenabled_manage              = $cisbench::params::rhnsdenabled_manage,) inherits cisbench::params {
  ensure_packages('yum-plugin-security')

  if $securityupdatesinstallled_report == true and $::cis['has_securityupdatesinstallled'] == false {
    notify { "Cisbench: System has available security patches. System needs to be updated!": require => Package['yum-plugin-security'
        ], }
  }

  if $::cis['has_oraclegpgkey'] == false and $oraclegpgkeyinstalled_report == true {
    notify { 'Cisbench: Oracle OSS Group gpg key for rpm packages not installed on your system!': }
  }

  if $oraclegpgkeyinstalled_manage == true {
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-oracle_tmp':
      ensure   => 'file',
      source   => 'puppet:///modules/cisbench/RPM-GPG-KEY-oracle-ol6',
      group    => '0',
      mode     => '0644',
      owner    => '0',
      selrange => 's0',
      selrole  => 'object_r',
      seltype  => 'cert_t',
      seluser  => 'system_u',
    }

    exec { 'rpm import oracle oss gpg key':
      command     => '/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle_tmp',
      refreshonly => true,
      subscribe   => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-oracle_tmp'],
    }
  }

  if $::cis['is_yumgpgcheckenabled'] == false and $yumgpgcheckenabled_report == true {
    notify { 'Cisbench: GPG checking for packages not enabled in your yum.conf!': }
  }

  if $yumgpgcheckenabled_manage == true {
    file { '/etc/yum.conf':
      ensure   => 'file',
      content  => template($yumconf_template),
      group    => '0',
      mode     => '0644',
      owner    => '0',
      selrange => 's0',
      selrole  => 'object_r',
      seltype  => 'etc_t',
      seluser  => 'system_u',
    }
  }

  if $::cis['is_rhnsddisabled'] == false and $rhnsdenabled_report == true {
    notify { 'Cisbench: Rhnsd service not disabled in all runlevels!': }
  }

  if $rhnsdenabled_manage == true {
    service { 'rhnsd':
      ensure => 'stopped',
      enable => false,
    }
  }

}
