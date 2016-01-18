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
) inherits cisbench::params {
  ensure_packages('yum-plugin-security')
}
