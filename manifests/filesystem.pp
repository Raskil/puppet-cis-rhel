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
  $homenodev_manage                = $cisbench::params::homenodev_manage,
  $devshmnodev_report              = $cisbench::params::devshmnodev_report,
  $devshmnodev_manage              = $cisbench::params::devshmnodev_manage,
  $devshmnosuid_report             = $cisbench::params::devshmnosuid_report,
  $devshmnosuid_manage             = $cisbench::params::devshmnosuid_manage,
  $devshmnoexec_report             = $cisbench::params::devshmnoexec_report,
  $devshmnoexec_manage             = $cisbench::params::devshmnoexec_manage,
  $stickybitforwwd_report          = $cisbench::params::stickybitforwwd_report,
  $cramfsdisabled_report           = $cisbench::params::cramfsdisabled_report,
  $cramfsdisabled_manage           = $cisbench::params::cramfsdisabled_manage,
  $freevxfsdisabled_report         = $cisbench::params::freevxfsdisabled_report,
  $freevxfsdisabled_manage         = $cisbench::params::freevxfsdisabled_manage,
  $jffs2disabled_report            = $cisbench::params::jffs2disabled_report,
  $jffs2disabled_manage            = $cisbench::params::jffs2disabled_manage,
  $hfsdisabled_report              = $cisbench::params::hfsdisabled_report,
  $hfsdisabled_manage              = $cisbench::params::hfsdisabled_manage,
  $hfsplusdisabled_report          = $cisbench::params::hfsplusdisabled_report,
  $hfsplusdisabled_manage          = $cisbench::params::hfsplusdisabled_manage,
  $squashfsdisabled_report         = $cisbench::params::squashfsdisabled_report,
  $squashfsdisabled_manage         = $cisbench::params::squashfsdisabled_manage,
  $udfdisabled_report              = $cisbench::params::udfdisabled_report,
  $udfdisabled_manage              = $cisbench::params::udfdisabled_manage,) inherits cisbench::params {
  if $::cis['is_tmpseparatemount'] == false and $tmpseparatemount_report == true {
    notify { "Cisbench: /tmp is not on a separate mount. Failed tmpseparatemount_report check.": }
  }

  if $::cis['is_varseparatemount'] == false and $varseparatemount_report == true {
    notify { "Cisbench: /var is not on a separate mount. Failed varseparatemount_report check.": }
  }

  if $::cis['is_varlogseparatemount'] == false and $varlogseparatemount_report == true {
    notify { "Cisbench: /var/log is not on a separate mount. Failed varlogseparatemount_report check.": }
  }

  if $::cis['is_varlogauditseparatemount'] == false and $varlogauditseparatemount_report == true {
    notify { "Cisbench: /var/log/audit is not on a separate mount. Failed varlogauditseparatemount_report check.": }
  }

  if $::cis['is_homeseparatemount'] == false and $homeseparatemount_report == true {
    notify { "Cisbench: /home is not on a separate mount. Failed homeseparatemount_report check.": }
  }

  if $::cis['is_tmpnodev'] == false and $tmpnodev_report == true {
    notify { "Cisbench: /tmp has no nodev option. Failed tmpnodev_report check.": }
  }

  if $::cis['is_tmpnosuid'] == false and $tmpnosuid_report == true {
    notify { "Cisbench: /tmp has no nosuid option. Failed tmpnosuid_report check.": }
  }

  if $::cis['is_tmpnoexec'] == false and $tmpnoexec_report == true {
    notify { "Cisbench: /tmp has no noexec option. Failed tmpnoexec_report check.": }
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
      fail("Cisbench: Not able to manage /tmp mount options, because /tmp is not a separate mount. Eiter Make /tmp separate mount or disable the manage options for /tmp device of the cis module."
      )
    }
  }

  if $::cis['is_tmpbindmount'] == false and $tmpbindmount_report == true {
    notify { "Cisbench: No bindmount /var/tmp /tmp detected. Failed tmpbindmount_report check.": }
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
      fail("Cisbench: Not able to do /var/tmp bind mount to /tmp, because /tmp is not a separate mount. Eiter Make /tmp separate mount or disable the manage options for /var/tmp bindmount device of the cis module."
      )
    }
  }

  if $::cis['is_homenodev'] == false and $homenodev_report == true {
    notify { "Cisbench: /home has no nodev option. Failed homenodev_report check.": }
  }

  if $homenodev_manage == true {
    if $::cis['is_homeseparatemount'] == true {
      mount { '/home':
        ensure  => 'mounted',
        dump    => '1',
        options => 'defaults,nodev',
        pass    => '2',
        target  => '/etc/fstab',
      }
    } else {
      fail("Cisbench: Not able to manage /home mount options, because /home is not a separate mount. Eiter Make /home separate mount or disable the manage options for /home device of the cis module."
      )
    }
  }

  if $::cis['is_devshmnodev'] == false and $devshmnodev_report == true {
    notify { "Cisbench: /dev/shm has no nodev option. Failed devshmnodev_report check.": }
  }

  if $::cis['is_devshmnosuid'] == false and $devshmnosuid_report == true {
    notify { "Cisbench: /dev/shm has no nosuid option. Failed devshmnosuid_report check.": }
  }

  if $::cis['is_devshmnoexec'] == false and $devshmnoexec_report == true {
    notify { "Cisbench: /dev/shm has no noexec option. Failed devshmnoexec_report check.": }
  }

  if $stickybitforwwd_report == true {
    $filefactsinhib = 'present'

    if $::cis['world_writeable_dirs_without_sb'] != undef and is_array($::cis['world_writeable_dirs_without_sb']) and !empty($::cis['world_writeable_dirs_without_sb'
      ]) {
      $dirs = join($::cis['world_writeable_dirs_without_sb'], ', ')

      notify { "Cisbench: Cisbench module found world writeable directorys without a sticky bit an your system! ${dirs}": }
    }
  } else {
    $filefactsinhib = 'absent'
  }

  file { '/etc/puppet_cis_module_searchwwrdirs':
    content => template('cisbench/puppet_cis_module_searchwwrdirs.erb'),
    ensure  => $filefactsinhib,
  }

  if $devshmnodev_manage == true or $devshmnosuid_manage == true or $devshmnoexec_manage == true {
    mount { '/dev/shm':
      ensure  => 'mounted',
      dump    => '1',
      options => inline_template('defaults<% if @devshmnodev_manage -%>,nodev<% end -%><% if @devshmnosuid_manage -%>,nosuid<% end -%><% if @devshmnoexec_manage -%>,noexec<% end -%>'
      ),
      pass    => '2',
      target  => '/etc/fstab',
    }
  }

  if $::cis['is_cramfsdisabled'] == false and $cramfsdisabled_report == true {
    notify { "Cisbench: Cramfs is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_freevxfsdisabled'] == false and $freevxfsdisabled_report == true {
    notify { "Cisbench: Freevxfs is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_jffs2disabled'] == false and $jffs2disabled_report == true {
    notify { "Cisbench: jffs2 is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_hfsdisabled'] == false and $hfsdisabled_report == true {
    notify { "Cisbench: hfs is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_hfsplusdisabled'] == false and $hfsplusdisabled_report == true {
    notify { "Cisbench: hfsplus is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_squashfsdisabled'] == false and $squashfsdisabled_report == true {
    notify { "Cisbench: squashfs is not disabled in your modprobe configuration!": }
  }

  if $::cis['is_udfdisabled'] == false and $udfdisabled_report == true {
    notify { "Cisbench: udf is not disabled in your modprobe configuration!": }
  }

  file { '/etc/modprobe.d/CIS.conf':
    ensure   => 'file',
    content  => template('cisbench/modprobe_CIS.conf'),
    group    => '0',
    mode     => '0644',
    owner    => '0',
    selrange => 's0',
    selrole  => 'object_r',
    seltype  => 'modules_conf_t',
    seluser  => 'system_u',
  }
}
