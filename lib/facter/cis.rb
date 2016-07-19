require 'facter'


Facter.add(:cis) do
  confine :osfamily => "RedHat"
  confine :operatingsystemmajrelease => '6'
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
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v cramfs 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_cramfsdisabled'] =  true
    else
      cishash['is_cramfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v freevxfs 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_freevxfsdisabled'] =  true
    else
      cishash['is_freevxfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v jffs2 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_jffs2disabled'] =  true
    else
      cishash['is_jffs2disabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v hfs 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_hfsdisabled'] =  true
    else
      cishash['is_hfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v hfsplus 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_hfsplusdisabled'] =  true
    else
      cishash['is_hfsplusdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v squashfs 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_squashfsdisabled'] =  true
    else
      cishash['is_squashfsdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/sbin/modprobe -n -v udf 2>&1')
    if returnval.include? 'install /bin/true'
      cishash['is_udfdisabled'] =  true
    else
      cishash['is_udfdisabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY')
    if returnval.include? 'Key fingerprint = 4214 4123 FECF C55B 9086  313D 72F9 7B74 EC55 1F03'
      cishash['has_oraclegpgkey'] =  true
    else
      cishash['has_oraclegpgkey'] =  false
    end
    returnval = Facter::Core::Execution.exec('yum check-update --security > /dev/null 2>&1; echo $?')
    if returnval == '100' or returnval == '1'
      cishash['has_updatesinstallled'] =  false
    else
      cishash['has_updatesinstallled'] =  true
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]*[[:space:]]*gpgcheck[[:space:]]*=[[:space:]]*1\' /etc/yum.conf')
    if returnval.include? 'gpgcheck'
      cishash['is_yumgpgcheckenabled'] =  true
    else
      cishash['is_yumgpgcheckenabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('chkconfig --list rhnsd 2>&1 | grep :on')
    if returnval.include? ':on'
      cishash['is_rhnsddisabled'] =  false
    else
      cishash['is_rhnsddisabled'] =  true
    end
    returnval = Facter::Core::Execution.exec('chkconfig --list yum-updatesd 2>&1 | grep :on')
    if returnval.include? ':on'
      cishash['is_yumupdatesddisabled'] =  false
    else
      cishash['is_yumupdatesddisabled'] =  true
    end
    returnval = Facter::Core::Execution.exec('yum check-update > /dev/null 2>&1; echo $?')
    if returnval == '100' or returnval == '1'
      cishash['has_updatesinstallled'] =  false
    else
      cishash['has_updatesinstallled'] =  true
    end
    if File.exist? '/usr/sbin/aide'
      cishash['is_aideinstalled'] = true
    else
      cishash['is_aideinstalled'] = false
    end
    if File.exist? '/etc/puppet_cis_module_checkrpminteg'
      returnval = Facter::Core::Execution.exec('rpm -qVa | awk \'$2 != "c" { print $2}\'')
      cishash['files_from_rpms_faildchecksum'] = returnval.split(/\n+/)
    end
    returnval = Facter::Core::Execution.exec('crontab -u root -l | grep aide > /dev/null 2>&1; echo $?')
    if returnval == '0'
      cishash['is_aidecroninstalled'] =  true
    else
      returnval = Facter::Core::Execution.exec('grep -R aide /etc/crontab /etc/cron.* > /dev/null 2>&1; echo $?')
      if returnval == '0'
        cishash['is_aidecroninstalled'] =  true
      else
        cishash['is_aidecroninstalled'] =  false
      end
    end
    returnval = Facter::Core::Execution.exec('grep selinux=0 /etc/grub.conf > /dev/null 2>&1; echo $?')
    if returnval == '0'
      cishash['is_selinuxbootenabled'] =  false
    else
      cishash['is_selinuxbootenabled'] =  true
    end
    returnval = Facter::Core::Execution.exec('grep enforcing=0 /etc/grub.conf > /dev/null 2>&1; echo $?')
    if returnval == '0'
      cishash['is_selinuxbootenforcing'] =  false
    else
      cishash['is_selinuxbootenforcing'] =  true
    end    
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]*[[:space:]]*SELINUX[[:space:]]*=[[:space:]]*enforcing\' /etc/selinux/config')
    if returnval.include? 'enforcing'
      cishash['is_selinuxconfigenforcing'] =  true
    else
      cishash['is_selinuxconfigenforcing'] =  false
    end
    returnval = Facter::Core::Execution.exec('getenforce')
    if returnval.include? 'Enforcing'
      cishash['is_selinuxenforcing'] =  true
    else
      cishash['is_selinuxenforcing'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]*[[:space:]]*SELINUXTYPE[[:space:]]*=[[:space:]]*[targeted\\|mls]\' /etc/selinux/config > /dev/null 2>&1; echo $?')
    if returnval == '0'
      cishash['is_selinuxpolicyrecommended'] =  true
    else
      cishash['is_selinuxpolicyrecommended'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q setroubleshoot > /dev/null 2>&1; echo $?')
    if returnval == '1'
      cishash['has_nosetroubleshootrpm'] =  true
    else
      cishash['has_nosetroubleshootrpm'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q mcstrans > /dev/null 2>&1; echo $?')
    if returnval == '1'
      cishash['has_nomcstransrpm'] =  true
    else
      cishash['has_nomcstransrpm'] =  false
    end
    returnval = Facter::Core::Execution.exec('ps -eZ | egrep "initrc" | egrep -vw "tr|ps|egrep|bash|awk" | tr \':\' \' \' | awk \'{ print $NF "-" $5 }\' 2> /dev/null')
    cishash['selinux_unconfined_deamons'] = returnval.split(/\n+/)
    returnval = Facter::Core::Execution.exec('ps -eZ | egrep "unconfined" | egrep -vw "tr|ps|egrep|bash|awk" | tr \':\' \' \' | awk \'{ print $NF "-" $5 }\' 2> /dev/null')
    cishash['selinux_unconfined_deamons'] + returnval.split(/\n+/)
    returnval = Facter::Core::Execution.exec('stat -L -c "%u %g" /etc/grub.conf | egrep "0 0"')
    if returnval.include? '0 0'
      cishash['is_grubconfownedbyroot'] =  true
    else
      cishash['is_grubconfownedbyroot'] =  false
    end  
    returnval = Facter::Core::Execution.exec('stat -L -c "%a" /etc/grub.conf | egrep ".00"')
    if returnval.include? '00'
      cishash['has_grubconfnoaccess'] =  true
    else
      cishash['has_grubconfnoaccess'] =  false
    end
    returnval = Facter::Core::Execution.exec('grep "^password" /etc/grub.conf')
    if returnval.include? 'password'
      cishash['has_grubpassword'] =  true
    else
      cishash['has_grubpassword'] =  false
    end
    returnval = Facter::Core::Execution.exec('grep "^SINGLE" /etc/sysconfig/init')
    if returnval.include? 'sulogin'
      cishash['has_singleusermodelogin'] =  true
    else
      cishash['has_singleusermodelogin'] =  false
    end
    returnval = Facter::Core::Execution.exec('grep "^PROMPT" /etc/sysconfig/init')
    if returnval.include? 'yes'
      cishash['has_nointeractiveboot'] =  false
    else
      cishash['has_nointeractiveboot'] =  true
    end
    returnval = Facter::Core::Execution.exec('grep "\*[[:space:]]*hard[[:space:]]*core" /etc/security/limits.conf')
    if returnval.include? '0'
      cishash['is_coredumpdisabled'] =  true
    else
      returnval = Facter::Core::Execution.exec('grep -R "\*[[:space:]]*hard[[:space:]]*core" /etc/security/limits.d/*.conf')
      if returnval.include? '0'
        cishash['is_coredumpdisabled'] =  true
      else
        cishash['is_coredumpdisabled'] =  false
      end
    end
    returnval = Facter::Core::Execution.exec('sysctl fs.suid_dumpable')
    if returnval.include? 'fs.suid_dumpable = 0'
      cishash['is_suiddumpdisabled'] =  true
    else
      cishash['is_suiddumpdisabled'] =  false
    end
    if Facter.value(:kernelrelease).include? 'uek'
      cishash['is_execshieldenabled'] =  false
    else
      returnval = Facter::Core::Execution.exec('sysctl kernel.exec-shield')
      if returnval.include? 'kernel.exec-shield = 1'
        cishash['is_execshieldenabled'] =  true
      else
        cishash['is_execshieldenabled'] =  false
      end
    end
    returnval = Facter::Core::Execution.exec('sysctl kernel.randomize_va_space')
    if returnval.include? 'kernel.randomize_va_space = 2'
      cishash['is_randvaenabled'] =  true
    else
      cishash['is_randvaenabled'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q telnet-server > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notelnetserver'] =  true
    else
      cishash['has_notelnetserver'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q telnet > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notelnet'] =  true
    else
      cishash['has_notelnet'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q rsh-server > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_norshserver'] =  true
    else
      cishash['has_norshserver'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q rsh > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_norsh'] =  true
    else
      cishash['has_norsh'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q ypbind > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_noypbind'] =  true
    else
      cishash['has_noypbind'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q ypserv > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_noypserv'] =  true
    else
      cishash['has_noypserv'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q tftp > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notftp'] =  true
    else
      cishash['has_notftp'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q tftp-server > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notftpserver'] =  true
    else
      cishash['has_notftpserver'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q talk > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notalk'] =  true
    else
      cishash['has_notalk'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q talk-server > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_notalkserver'] =  true
    else
      cishash['has_notalkserver'] =  false
    end
    returnval = Facter::Core::Execution.exec('/bin/rpm -q xinetd > /dev/null 2>&1; echo $?')
    if returnval  == '1'
      cishash['has_noxinetd'] =  true
    else
      cishash['has_noxinetd'] =  false
    end

    disablededservices = Array['chargen-dgram', 'chargen-stream', 'daytime-dgram', 'daytime-stream', 'echo-dgram', 'echo-stream', 'tcpmux-server']
    disablededservices.each do |item|
      returnval = Facter::Core::Execution.exec("/sbin/chkconfig --list #{item} | grep on > /dev/null 2>&1; echo $?")
      if returnval  == '1'
        cishash["is_#{item.gsub('-', '')}disabled"] =  true
      else
        cishash["is_#{item.gsub('-', '')}disabled"] =  false
      end
    end
    cishash
  end
end
