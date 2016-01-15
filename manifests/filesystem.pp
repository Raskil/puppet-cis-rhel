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
  $tmpseperatemount_report = $cisbench::params::tmpseperatemount_report,
  $varseperatemount_report = $cisbench::params::varseperatemount_report,
  $tmpnodev_report         = $cisbench::params::tmpnodev_report,
  $tmpnodev_manage         = $cisbench::params::tmpnodev_manage,
  $tmpnosuid_report        = $cisbench::params::tmpnosuid_report,
  $tmpnosuid_manage        = $cisbench::params::tmpnosuid_manage,
  $tmpnoexec_report        = $cisbench::params::tmpnoexec_report,
  $tmpnoexec_manage        = $cisbench::params::tmpnoexec_manage,) inherits cisbench::params {
  if $::cis['is_tmpseperatemount'] == false and $tmpseperatemount_report == true {
    notify { "/tmp is not on a separate mount. Failed tmpseperatemount_report check.": }
  }

  if $::cis['is_varseperatemount'] == false and $tmpseperatemount_report == true {
    notify { "/var is not on a separate mount. Failed varseperatemount_report check.": }
  }

  if $::cis['is_tmpnodev'] == false and $tmpnodev_report == true {
    notify { "/tmp has no nodev option. Failed tmpnodev_report check.": }
  }

  if $::cis['is_tmpnosuid'] == false and $tmpnosuid_report == true {
    notify { "/tmp has no nosuid option. Failed tmpnosuid_report check.": }
  }

  if $::cis['is_tmpnoexec'] == false and $tmpnoexec_report == true {
    notify { "/tmp has no noexec option. Failed tmpnoexec_report check.": }
  }

  if $tmpnodev_manage == true or $tmpnosuid_manage == true or $tmpnoexec_manage == true {
    if $::cis['is_tmpseperatemount'] == true {
      mount { '/tmp':
        ensure  => 'mounted',
        dump    => '1',
        options => inline_template('defaults<% if @tmpnodev_manage -%>,nodev<% end -%><% if @tmpnosuid_manage -%>,nosuid<% end -%><% if @tmpnoexec_manage -%>,noexec<% end -%>'
        ),
        pass    => '2',
        target  => '/etc/fstab',
      }
    } else {
      fail("Not able to manage /tmp mount options, because /tmp is not a seperate mount. Eiter Make /tmp seperate mount or disable the manage options for /tmp device of the cis module."
      )
    }
  }

}
