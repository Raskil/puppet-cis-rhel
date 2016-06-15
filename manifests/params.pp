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
  $managediffs      = false) {
  validate_bool($managediffs)
  validate_integer($cisleveldefaults)
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
  $stickybitforwwd_report = false
  $securityupdatesinstallled_report = true
  $oraclegpgkeyinstalled_report = true
  $oraclegpgkeyinstalled_manage = $managediffs
  $yumgpgcheckenabled_report = true
  $yumgpgcheckenabled_manage = $managediffs
  $yumconf_template = 'cisbench/yum.conf.erb'
  $updatesinstallled_report = true
  $rpmcheckintegrity_report = false
  $aidedbpath = '/var/lib/aide/aide.db.gz'
  $aidedbpath_out = '/var/lib/aide/aide.db.new.gz'
  $aideconf_path = '/etc/aide.conf'
  $selinuxconfigenforcing_selinux = 'enforcing'
  $selinuxconfigenforcing_selinuxtype = 'targeted'
  $grubconfownedbyroot_report = true
  $grubconfownedbyroot_manage = $managediffs
  $grubconfnoaccess_report = true
  $grubconfnoaccess_manage = $managediffs
  $grubpassword_report = true
  $grubpassword_manage = $managediffs
  $singleusermodelogin_report = true
  $singleusermodelogin_manage = $managediffs
  $nointeractiveboot_report = true
  $nointeractiveboot_manage = $managediffs
  $coredumpdisabled_report = true
  $coredumpdisabled_manage = $managediffs
  $suiddumpdisabled_report = true
  $suiddumpdisabled_manage = $managediffs
  $execshieldenabled_report = true
  $execshieldenabled_manage = $managediffs
  $randvaenabled_report = true
  $randvaenabled_manage = $managediffs
  $notelnetserver_report = true
  $notelnetserver_manage = $managediffs

  case $cisleveldefaults {
    1       : {
      $cramfsdisabled_report = false
      $cramfsdisabled_manage = false
      $freevxfsdisabled_report = false
      $freevxfsdisabled_manage = false
      $jffs2disabled_report = false
      $jffs2disabled_manage = false
      $hfsdisabled_report = false
      $hfsdisabled_manage = false
      $hfsplusdisabled_report = false
      $hfsplusdisabled_manage = false
      $squashfsdisabled_report = false
      $squashfsdisabled_manage = false
      $udfdisabled_report = false
      $udfdisabled_manage = false
      $rhnsddisabled_report = false
      $rhnsddisabled_manage = false
      $yumupdatesddisabled_report = false
      $yumupdatesddisabled_manage = false
      $aideinstalled_report = false
      $aideinstalled_manage = false
      $aidecron_report = false
      $aidecron_manage = false
      $selinuxgrubenabled_report = false
      $selinuxgrubenabled_manage = false
      $selinuxconfigenforcing_report = false
      $selinuxconfigenforcing_manage = false
      $selinuxenforcing_report = false
      $selinuxenforcing_manage = false
      $selinuxpolicyrecommended_report = false
      $nosetroubleshootrpm_report = false
      $nosetroubleshootrpm_manage = false
      $nomcstransrpm_report = false
      $nomcstransrpm_manage = false
      $unconfinedprocesses_report = false

    }
    2       : {
      $cramfsdisabled_report = true
      $cramfsdisabled_manage = $managediffs
      $freevxfsdisabled_report = true
      $freevxfsdisabled_manage = $managediffs
      $jffs2disabled_report = true
      $jffs2disabled_manage = $managediffs
      $hfsdisabled_report = true
      $hfsdisabled_manage = $managediffs
      $hfsplusdisabled_report = true
      $hfsplusdisabled_manage = $managediffs
      $squashfsdisabled_report = true
      $squashfsdisabled_manage = $managediffs
      $udfdisabled_report = true
      $udfdisabled_manage = $managediffs
      $yumupdatesddisabled_report = true
      $yumupdatesddisabled_manage = $managediffs
      $aideinstalled_report = true
      $aideinstalled_manage = $managediffs
      $aidecron_report = true
      $aidecron_manage = $managediffs
      $selinuxgrubenabled_report = true
      $selinuxgrubenabled_manage = $managediffs
      $selinuxconfigenforcing_report = true
      $selinuxconfigenforcing_manage = $managediffs
      $selinuxenforcing_report = false
      $selinuxenforcing_manage = $managediffs
      $selinuxpolicyrecommended_report = true
      $nosetroubleshootrpm_report = true
      $nosetroubleshootrpm_manage = $managediffs
      $nomcstransrpm_report = true
      $nomcstransrpm_manage = $managediffs
      $unconfinedprocesses_report = true
    }
    default : {
      fail("Cisbench: Params Class does not support values other than 1 or 2 for parameter \$cisleveldefaults. You supplied: ${cisleveldefaults}.")
    }

  }

}
