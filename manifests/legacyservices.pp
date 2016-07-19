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
  $notelnet_manage       = $cisbench::params::notelnet_manage,
  $norshserver_report    = $cisbench::params::norshserver_report,
  $norshserver_manage    = $cisbench::params::norshserver_manage,
  $norsh_report          = $cisbench::params::norsh_report,
  $norsh_manage          = $cisbench::params::norsh_manage,
  $noypbind_report       = $cisbench::params::noypbind_report,
  $noypbind_manage       = $cisbench::params::noypbind_manage,
  $noypserv_report       = $cisbench::params::noypserv_report,
  $noypserv_manage       = $cisbench::params::noypserv_manage,
  $notftp_report         = $cisbench::params::notftp_report,
  $notftp_manage         = $cisbench::params::notftp_manage,
  $notftpserver_report   = $cisbench::params::notftpserver_report,
  $notftpserver_manage   = $cisbench::params::notftpserver_manage,
  $notalk_report         = $cisbench::params::notalk_report,
  $notalk_manage         = $cisbench::params::notalk_manage,) inherits cisbench::params {
  validate_bool($notelnetserver_report)
  validate_bool($notelnetserver_manage)
  validate_bool($notelnet_report)
  validate_bool($notelnet_manage)
  validate_bool($norshserver_report)
  validate_bool($norshserver_manage)
  validate_bool($norsh_report)
  validate_bool($norsh_manage)
  validate_bool($noypbind_report)
  validate_bool($noypbind_manage)
  validate_bool($noypserv_report)
  validate_bool($noypserv_manage)
  validate_bool($notftp_report)
  validate_bool($notftp_manage)
  validate_bool($notftpserver_report)
  validate_bool($notftpserver_manage)

  if $::cis['has_notelnetserver'] == false and $notelnetserver_report == true {
    notify { 'Cisbench: Telnet-Server is installed on your system!': }
  }

  if $notelnetserver_manage == true {
    package { 'telnet-server': ensure => 'absent', }
  }

  if $::cis['has_notelnet'] == false and $notelnet_report == true {
    notify { 'Cisbench: Telnet client is installed on your system!': }
  }

  if $notelnet_manage == true {
    package { 'telnet': ensure => 'absent', }
  }

  if $::cis['has_norshserver'] == false and $norshserver_report == true {
    notify { 'Cisbench: rsh-Server is installed on your system!': }
  }

  if $norshserver_manage == true {
    package { 'rsh-server': ensure => 'absent', }
  }

  if $::cis['has_norsh'] == false and $norsh_report == true {
    notify { 'Cisbench: rsh client is installed on your system!': }
  }

  if $norsh_manage == true {
    package { 'rsh': ensure => 'absent', }
  }

  if $::cis['has_noypbind'] == false and $noypbind_report == true {
    notify { 'Cisbench: ypbind client is installed on your system!': }
  }

  if $noypbind_manage == true {
    package { 'ypbind': ensure => 'absent', }
  }

  if $::cis['has_noypserv'] == false and $noypserv_report == true {
    notify { 'Cisbench: ypserv nis server is installed on your system!': }
  }

  if $noypbind_manage == true {
    package { 'ypserv': ensure => 'absent', }
  }

  if $::cis['has_notftp'] == false and $notftp_report == true {
    notify { 'Cisbench: tftp is installed on your system!': }
  }

  if $notftp_manage == true {
    package { 'tftp': ensure => 'absent', }
  }

  if $::cis['has_notftpserver'] == false and $notftpserver_report == true {
    notify { 'Cisbench: tftp-server is installed on your system!': }
  }

  if $notftpserver_manage == true {
    package { 'tftp-server': ensure => 'absent', }
  }

  if $::cis['has_notalk'] == false and $notalk_report == true {
    notify { 'Cisbench: talk is installed on your system!': }
  }

  if $notalk_manage == true {
    package { 'talk': ensure => 'absent', }
  }

}
