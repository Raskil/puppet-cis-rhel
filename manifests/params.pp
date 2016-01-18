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
  $homenodev_report = true
  $homenodev_manage = $managediffs
  $devshmnodev_report = true
  $devshmnodev_manage = $managediffs
  $devshmnosuid_report = true
  $devshmnosuid_manage = $managediffs
  $devshmnoexec_report = true
  $devshmnoexec_manage = $managediffs
  $stickybitforwwd_report = true

  case $cisleveldefaults {
    1       : {
      $cramfsdisabled_report = true
      $cramfsdisabled_manage = true
    }
    2       : {
      $cramfsdisabled_report = true
      $cramfsdisabled_manage = true
    }
    default : {
      fail("Cisbench: Params Class does not support values other than 1 or 2 for parameter \$cisleveldefaults. You supplied: ${cisleveldefaults}."
      )
    }

  }

}
