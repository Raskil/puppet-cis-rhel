require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    returnval = Facter::Core::Execution.exec('grep "[[:space:]]/tmp[[:space:]]" /etc/fstab')
    if returnval != ''
      cishash['is_tmpseperatemount'] =  true
    else
      cishash['is_tmpseperatemount'] =  false
    end
    cishash
  end
end