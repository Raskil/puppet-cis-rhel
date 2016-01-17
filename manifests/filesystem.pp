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
  $tmpseparatemount_report         = $cisbench::params::tmpseparatemount_report,
  $varseparatemount_report         = $cisbench::params::varseparatemount_report,
  $varlogseparatemount_report      = $cisbench::params::varlogseparatemount_report,
  $varlogauditseparatemount_report = $cisbench::params::varlogauditseparatemount_report,
  $homeseparatemount_report        = $cisbench::params::varlogauditseparatemount_report,
  $tmpnodev_report                 = $cisbench::params::tmpnodev_report,
  $tmpnodev_manage                 = $cisbench::params::tmpnodev_manage,
  $tmpnosuid_report                = $cisbench::params::tmpnosuid_report,
  $tmpnosuid_manage                = $cisbench::params::tmpnosuid_manage,
  $tmpnoexec_report                = $cisbench::params::tmpnoexec_report,
  $tmpnoexec_manage                = $cisbench::params::tmpnoexec_manage,
  $tmpbindmount_report             = $cisbench::params::tmpbindmount_report,
  $tmpbindmount_manage             = $cisbench::params::tmpbindmount_manage,
  $homenodev_report                = $cisbench::params::homenodev_report,
  $homenodev_manage                = $cisbench::params::homenodev_manage,) inherits cisbench::params {
  if $::cis['is_tmpseparatemount'] == false and $tmpseparatemount_report == true {
    notify { "/tmp is not on a separate mount. Failed tmpseparatemount_report check.": }
  }

  if $::cis['is_varseparatemount'] == false and $varseparatemount_report == true {
    notify { "/var is not on a separate mount. Failed varseparatemount_report check.": }
  }

  if $::cis['is_varlogseparatemount'] == false and $varlogseparatemount_report == true {
    notify { "/var/log is not on a separate mount. Failed varlogseparatemount_report check.": }
  }

  if $::cis['is_varlogauditseparatemount'] == false and $varlogauditseparatemount_report == true {
    notify { "/var/log/audit is not on a separate mount. Failed varlogauditseparatemount_report check.": }
  }

  if $::cis['is_homeseparatemount'] == false and $homeseparatemount_report == true {
    notify { "/home is not on a separate mount. Failed homeseparatemount_report check.": }
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
    if $::cis['is_tmpseparatemount'] == true {
      mount { '/tmp':
        ensure  => 'mounted',
        dump    => '1',
        options => inline_template('defaults<% if @tmpnodev_manage -%>,nodev<% end -%><% if @tmpnosuid_manage -%>,nosuid<% end -%><% if @tmpnoexec_manage -%>,noexec<% end -%>'
        ),
        pass    => '2',
        target  => '/etc/fstab',
      }
    } else {
      fail("Not able to manage /tmp mount options, because /tmp is not a separate mount. Eiter Make /tmp separate mount or disable the manage options for /tmp device of the cis module."
      )
    }
  }

  if $::cis['is_tmpbindmount'] == false and $tmpbindmount_report == true {
    notify { "No bindmount /var/tmp /tmp detected. Failed tmpbindmount_report check.": }
  }

  if $tmpbindmount_manage == true {
    if $::cis['is_tmpseparatemount'] == true {
      mount { '/var/tmp':
        ensure  => 'mounted',
        device  => '/tmp',
        dump    => '0',
        fstype  => 'none',
        options => 'bind',
        pass    => '0',
        target  => '/etc/fstab',
      }
    } else {
      fail("Not able to do /var/tmp bind mount to /tmp, because /tmp is not a separate mount. Eiter Make /tmp separate mount or disable the manage options for /var/tmp bindmount device of the cis module."
      )
    }
  }

  if $::cis['is_homenodev'] == false and $homenodev_report == true {
    notify { "/home has no nodev option. Failed homenodev_report check.": }
  }

  if $homenodev_manage == true {
    if $::cis['is_homeseparatemount'] == true {
      mount { '/home':
        ensure  => 'mounted',
        dump    => '1',
        options => inline_template('defaults<% if @homenodev_manage -%>,nodev<% end -%><% if @homenosuid_manage -%>,nosuid<% end -%><% if @homenoexec_manage -%>,noexec<% end -%>'
        ),
        pass    => '2',
        target  => '/etc/fstab',
      }
    } else {
      fail("Not able to manage /home mount options, because /home is not a separate mount. Eiter Make /home separate mount or disable the manage options for /home device of the cis module."
      )
    }
  }
}
