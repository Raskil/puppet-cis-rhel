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
  $tmpseparatemount_report = true
  $varseparatemount_report = true
  $varlogseparatemount_report = true
  $varlogauditseparatemount_report = true
  $tmpnodev_report = true
  $tmpnodev_manage = $managediffs
  $tmpnosuid_report = true
  $tmpnosuid_manage = $managediffs
  $tmpnoexec_report = true
  $tmpnoexec_manage = $managediffs
  $tmpbindmount_report = true
  $tmpbindmount_manage = $managediffs

  if $cisleveldefaults == 2 {
    $tmp = true
  }

}
