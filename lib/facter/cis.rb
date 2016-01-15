require 'facter'

# Check to see if rz.conf is there
Facter.add(:cis_is_tmpseperatemount) do
  confine :osfamily => "RedHat"
  cishash = {}
  setcode do
    returnval = Facter::Core::Execution.exec('grep "[[:space:]]/blah[[:space:]]" /etc/fstab')
    if returnval != ''
      true
    else
      false
    end
  end
end