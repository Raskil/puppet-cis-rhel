require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    tmp = 'grep "[[:space:]]/blah[[:space:]]" /etc/fstab' 
    if tmp != ''
      cishash['is_tmpseperatemount'] =  true
    else
      cishash['is_tmpseperatemount'] =  false
    end
    cishash
  end
end