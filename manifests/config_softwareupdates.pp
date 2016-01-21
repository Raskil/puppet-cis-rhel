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
  $oraclegpgkeyinstalled_manage     = $cisbench::params::oraclegpgkeyinstalled_manage,) inherits cisbench::params {
  ensure_packages('yum-plugin-security')

  if $securityupdatesinstallled_report == true and $::cis['has_securityupdatesinstallled'] == false {
    notify { "Cisbench: System has available security patches. System needs to be updated!": require => Package['yum-plugin-security'
        ], }
  }

  if $::cis['has_oraclegpgkey'] == false and $oraclegpgkeyinstalled_report == true {
    notify { "Cisbench: Oracle OSS Group gpg key for rpm packages not installed on your system!": }
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
      type     => 'file',
    }

    exec { 'rpm import oracle oss gpg key':
      command     => '/bin/rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle_tmp',
      refreshonly => true,
      subscribe   => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-oracle_tmp'],
    }
  }

}
