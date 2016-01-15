# Class: cisbench::params
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
class cisbench::params (
  $cisleveldefaults = 1,) {
  $tmpseperatemount_report = true

  if $cisleveldefaults = 2 {
    $tmp = true
  }

}
