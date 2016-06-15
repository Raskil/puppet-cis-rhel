# Class: cisbench::legacyservices
#
# This module manages cisbench legacyservices config
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cisbench::legacyservices (
  $notelnetserver_report = $cisbench::params::notelnetserver_report,
  $notelnetserver_manage = $cisbench::params::notelnetserver_manage,
  $notelnet_report       = $cisbench::params::notelnet_report,
  $notelnet_manage       = $cisbench::params::notelnet_manage,) inherits cisbench::params {
  validate_bool($notelnetserver_report)
  validate_bool($notelnetserver_manage)
  validate_bool($notelnet_report)
  validate_bool($notelnet_manage)

  if $::cis['has_notelnetserver'] == false and $notelnetserver_report == true {
    notify { 'Cisbench: Telnet-Server is installed on your system!': }
  }

  if $notelnetserver_manage == true {
    package { 'telnet-server': ensure => 'absent', }
  }

  if $::cis['has_notelnet'] == false and $notelnet_report == true {
    notify { 'Cisbench: Telnet-Server is installed on your system!': }
  }

  if $notelnet_manage == true {
    package { 'telnet': ensure => 'absent', }
  }

}
