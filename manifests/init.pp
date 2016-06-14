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
class cisbench (
) inherits cisbench::params {
  contain cisbench::filesystem
  contain cisbench::config_softwareupdates
  contain cisbench::aide
  contain cisbench::selinux
  contain cisbench::secureboot

  Class['cisbench::filesystem'] ->
  Class['cisbench::config_softwareupdates'] ->
  Class['cisbench::aide'] ->
  Class['cisbench::selinux'] ->
  Class['cisbench::secureboot']
}
