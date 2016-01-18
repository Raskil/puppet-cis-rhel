require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/tmp[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_tmpseparatemount'] =  true
    else
      cishash['is_tmpseparatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/var/log[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_varlogseparatemount'] =  true
    else
      cishash['is_varlogseparatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/var/log/audit[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_varlogauditseparatemount'] =  true
    else
      cishash['is_varlogauditseparatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/var[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_varseparatemount'] =  true
    else
      cishash['is_varseparatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/home[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_homeseparatemount'] =  true
    else
      cishash['is_homeseparatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/tmp[[:space:]]\' /etc/fstab | grep nodev')
    if returnval != ''
      cishash['is_tmpnodev'] =  true
    else
      cishash['is_tmpnodev'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/tmp[[:space:]]\' /etc/fstab | grep nosuid')
    if returnval != ''
      cishash['is_tmpnosuid'] =  true
    else
      cishash['is_tmpnosuid'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/tmp[[:space:]]\' /etc/fstab | grep noexec')
    if returnval != ''
      cishash['is_tmpnoexec'] =  true
    else
      cishash['is_tmpnoexec'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*/tmp[[:space:]]*/var/tmp\' /etc/fstab')
    if returnval != ''
      cishash['is_tmpbindmount'] =  true
    else
      cishash['is_tmpbindmount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/home[[:space:]]\' /etc/fstab | grep nodev')
    if returnval != ''
      cishash['is_homenodev'] =  true
    else
      cishash['is_homenodev'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/dev/shm[[:space:]]\' /etc/fstab | grep nodev')
    if returnval != ''
      cishash['is_devshmnodev'] =  true
    else
      cishash['is_devshmnodev'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/dev/shm[[:space:]]\' /etc/fstab | grep nosuid')
    if returnval != ''
      cishash['is_devshmnosuid'] =  true
    else
      cishash['is_devshmnosuid'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/dev/shm[[:space:]]\' /etc/fstab | grep noexec')
    if returnval != ''
      cishash['is_devshmnoexec'] =  true
    else
      cishash['is_devshmnoexec'] =  false
    end
    if File.exist? '/etc/puppet_cis_module_searchwwrdirs'
      returnval = Facter::Core::Execution.exec('df --local -P | awk {\'if (NR!=1) print $6\'} | xargs -I \'{}\' find \'{}\' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null')
      cishash['world_writeable_dirs_without_sb'] = returnval.split(/\n+/)
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v cramfs')
    if returnval.include? 'install /bin/true'
      cishash['is_cramfsdisabled'] =  true
    else
      cishash['is_cramfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v freevxfs')
    if returnval.include? 'install /bin/true'
      cishash['is_freevxfsdisabled'] =  true
    else
      cishash['is_freevxfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v jffs2')
    if returnval.include? 'install /bin/true'
      cishash['is_jffs2disabled'] =  true
    else
      cishash['is_jffs2disabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v hfs')
    if returnval.include? 'install /bin/true'
      cishash['is_hfsdisabled'] =  true
    else
      cishash['is_hfsdisabled'] =  false
    end
    cishash
  end
end