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

  Class['cisbench::filesystem'] ->
  Class['cisbench::config_softwareupdates'] ->
  Class['cisbench::aide'] ->
  Class['cisbench::selinux']
}
