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
  $selinuxgrubenabled_report          = $cisbench::params::selinuxgrubenabled_report,
  $selinuxgrubenabled_manage          = $cisbench::params::selinuxgrubenabled_manage,
  $selinuxconfigenforcing_report      = $cisbench::params::selinuxconfigenforcing_report,
  $selinuxconfigenforcing_manage      = $cisbench::params::selinuxconfigenforcing_manage,
  $selinuxconfigenforcing_selinux     = $cisbench::params::selinuxconfigenforcing_selinux,
  $selinuxconfigenforcing_selinuxtype = $cisbench::params::selinuxconfigenforcing_selinuxtype,
  $selinuxenforcing_report            = $cisbench::params::selinuxenforcing_report,
  $selinuxenforcing_manage            = $cisbench::params::selinuxenforcing_manage,
  $selinuxpolicyrecommended_report    = $cisbench::params::selinuxpolicyrecommended_report,
  $nosetroubleshootrpm_manage         = $cisbench::params::nosetroubleshootrpm_manage,
  $nosetroubleshootrpm_report         = $cisbench::params::nosetroubleshootrpm_report) inherits cisbench::params {
  validate_bool($selinuxgrubenabled_report)
  validate_bool($selinuxgrubenabled_manage)
  validate_bool($selinuxconfigenforcing_report)
  validate_bool($selinuxconfigenforcing_manage)
  validate_re($selinuxconfigenforcing_selinux, [
    '^enforcing$',
    "^permissive$",
    "^disabled$"], "Cisbench Module: \$selinuxconfigenforcing_selinux must be a string with one of the following values: \'enforcing|permissive|disabled\'. You supplied: ${selinuxconfigenforcing_selinux}")
  validate_string($selinuxconfigenforcing_selinuxtype)
  validate_bool($selinuxenforcing_report)
  validate_bool($selinuxenforcing_manage)
  validate_bool($selinuxpolicyrecommended_report)

  if $::cis['is_selinuxbootenabled'] == false and $selinuxgrubenabled_report == true {
    notify { 'Cisbench: Selinux is disabled in Grub Boot Config!': }
  }

  if $selinuxgrubenabled_manage == true {
    kernel_parameter { "selinux": ensure => absent, }
  }

  if $::cis['is_selinuxconfigenforcing'] == false and $selinuxconfigenforcing_report == true {
    notify { 'Cisbench: Selinux is disabled in SeLinux Config File!': }
  }

  if $selinuxconfigenforcing_manage == true {
    file { '/etc/selinux/config':
      ensure   => 'file',
      content  => template('cisbench/selinux.erb'),
      group    => 'root',
      mode     => '0644',
      owner    => 'root',
      selrange => 's0',
      selrole  => 'object_r',
      seltype  => 'selinux_config_t',
      seluser  => 'system_u',
    }
  }

  if $::cis['is_selinuxenforcing'] == false and $selinuxenforcing_report == true {
    notify { 'Cisbench: Selinux is disabled on runtime!': }
  }

  if $selinuxenforcing_manage == true {
    exec { '/usr/sbin/setenforce 1':
      user   => 'root',
      unless => '/usr/sbin/getenforce 2>&1 | /bin/grep Enforcing',
    }
  }

  if $::cis['is_selinuxpolicyrecommended'] == false and $selinuxpolicyrecommended_report == true {
    notify { 'Cisbench: Selinux not configured to use the recommended policies of targeted or mls!': }
  }

  if $::cis['has_nosetroubleshootrpm'] == false and $nosetroubleshootrpm_report == true {
    notify { 'Cisbench: Setroubleshoot package is installed!': }
  }

  if $nosetroubleshootrpm_manage == true {
    package { 'setroubleshoot': ensure => 'absent', }
  }

}
