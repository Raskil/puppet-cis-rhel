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
  Class['cisbench::filesystem'] ->
  Class['cisbench::config_softwareupdates']
}
