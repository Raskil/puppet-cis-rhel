# Class: cisbench::filesystem
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
class cisbench::filesystem (
  $tmpseperatemount_report = $cisbench::params::tmpseperatemount_report,) inherits cisbench::params {
    notify {"${::cis}"}
  if $::is_tmpseperatemount == false {
    notify { "/tmp is not on a separate mount. Failed tmpseperatemount_report check.": }
  }
}
