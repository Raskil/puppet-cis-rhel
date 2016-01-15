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
  $cisleveldefaults = 1,
  $managediffs      = true) {
  $tmpseperatemount_report = true
  $varseperatemount_report = true
  $tmpnodev_report = true
  $tmpnodev_manage = $managediffs
  $tmpnosuid_report = true
  $tmpnosuid_manage = $managediffs
  $tmpnoexec_report = true
  $tmpnoexec_manage = $managediffs

  if $cisleveldefaults == 2 {
    $tmp = true
  }

}
