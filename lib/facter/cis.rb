require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    
    if 'grep "[[:space:]]/blah[[:space:]]" /etc/fstab'
      cishash['is_tmpseperatemount'] =  true
    else
      cishash['is_tmpseperatemount'] =  false
    end
    cishash
  end
end