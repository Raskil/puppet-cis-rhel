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
  $cisleveldefaults = 2,
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
  $cramfsdisabled_report = false
  $cramfsdisabled_manage = false

  if $cisleveldefaults == 2 {
    $cramfsdisabled_report = true
    $cramfsdisabled_manage = false
  }

}
