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
  $rhnsddisabled_report             = $cisbench::params::rhnsddisabled_report,
  $rhnsddisabled_manage             = $cisbench::params::rhnsddisabled_manage,
  $yumupdatesddisabled_report       = $cisbench::params::yumupdatesddisabled_report,
  $yumupdatesddisabled_manage       = $cisbench::params::yumupdatesddisabled_manage,
  $updatesinstallled_report         = $cisbench::params::updatesinstallled_report,
  $rpmcheckintegrity_report         = $cisbench::params::rpmcheckintegrity_report) inherits cisbench::params {
  ensure_packages('yum-plugin-security')

  if $securityupdatesinstallled_report == true and $::cis['has_securityupdatesinstallled'] == false {
    notify { "Cisbench: System has available security patches. System needs to be updated!": require => Package['yum-plugin-security'], }
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

  if $::cis['is_rhnsddisabled'] == false and $rhnsddisabled_report == true {
    notify { 'Cisbench: Rhnsd service not disabled in all runlevels!': }
  }

  if $rhnsddisabled_manage == true {
    service { 'rhnsd':
      ensure => 'stopped',
      enable => false,
    }
  }

  if $::cis['is_yumupdatesddisabled'] == false and $yumupdatesddisabled_report == true {
    notify { 'Cisbench: Yum-updatesd service not disabled in all runlevels!': }
  }

  if $yumupdatesddisabled_manage == true {
    service { 'yum-updatesd':
      ensure => 'stopped',
      enable => false,
    }
  }

  if $updatesinstallled_report == true and $::cis['has_updatesinstallled'] == false {
    notify { "Cisbench: System has available patches. System needs to be updated!": }
  }

  if $rpmcheckintegrity_report == true {
    $rpmcheckintegrity_inhib = 'present'

    if $::cis['files_from_rpms_faildchecksum'] != undef and is_array($::cis['files_from_rpms_faildchecksum']) and !empty($::cis['files_from_rpms_faildchecksum']) {
      $files = join($::cis['files_from_rpms_faildchecksum'], ', ')

      notify { "Cisbench: Cisbench module found non-config files which no longer match with rpm checksum: ${files}": }
    }
  } else {
    $rpmcheckintegrity_inhib = 'absent'
  }

  file { '/etc/puppet_cis_module_checkrpminteg':
    content => template('cisbench/puppet_cis_module_checkrpminteg.erb'),
    ensure  => $rpmcheckintegrity_inhib,
  }
}
