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
class cisbench::config_softwareupdates (
  $securityupdatesinstallled_report = $cisbench::params::securityupdatesinstallled_report,) inherits cisbench::params {
  ensure_packages('yum-plugin-security')

  if $securityupdatesinstallled_report == true and $::cis['has_securityupdatesinstallled'] == true {
    notify { "Cisbench: System has available security patches. System needs to be updated!": after => Package['yum-plugin-security'
        ], }
  }
}
