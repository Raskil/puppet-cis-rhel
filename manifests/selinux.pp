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
  $selinuxenforcing_manage            = $cisbench::params::selinuxenforcing_manage) inherits cisbench::params {
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

}
