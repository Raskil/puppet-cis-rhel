require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/tmp[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_tmpseperatemount'] =  true
    else
      cishash['is_tmpseperatemount'] =  false
    end
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*[^#]{1,}.*[[:space:]]/var[[:space:]]\' /etc/fstab')
    if returnval != ''
      cishash['is_varseperatemount'] =  true
    else
      cishash['is_varseperatemount'] =  false
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
    returnval = Facter::Core::Execution.exec('egrep \'^[[:space:]]*/tmp[[:space:]]*/var/tmp\' /etc/fstab | grep noexec')
    if returnval != ''
      cishash['is_tmpbindmount'] =  true
    else
      cishash['is_tmpbindmount'] =  false
    end
    cishash
    
  end
end