Puppet::Type.newtype(:printer) do
  @doc = "Manage installed printers and printer queues on a puppet node."

  ensurable

  newparam(:name, :isnamevar => true) do
    desc "The name of the printer, any character except SPACE, TAB, / or #, Not case sensitive"

    validate do |value|
      raise ArgumentError, "%s is not a valid printer name" % value if value =~ /[\s\t\/#]/
    end
  end

  newparam(:uri) do
    desc "Sets the device-uri attribute of the printer queue."
  end

  newparam(:description) do
    desc "Provides a textual description of the destination."
  end

  newparam(:location) do
    desc "Provides a textual location of the destination."
  end

  newparam(:ppd) do
    desc "Specifies a PostScript Printer Description file to use with the printer."
  end

  newparam(:enabled) do
    desc "Enables the destination and accepts jobs"

    newvalues(:true, :false)
    defaultto :true
  end

  newparam(:accept) do
    desc "Specifies whether the destination will accept jobs, or reject them."

    newvalues(:true, :false)
    defaultto :true
  end

  newparam(:shared) do
    desc "Sets the destination to shared/published or unshared/unpublished."

    newvalues(:true, :false)
    defaultto :false
  end

  newparam(:options) do
    desc "Sets a PPD option for the printer"

    validate do |value|
      raise ArgumentError, "invalid value supplied for printer options" unless value.is_a? Hash
    end
  end

  # Allow a printer resource without explicitly specifying a file resource for the PPD.
  autorequire(:file) do
     self[:ppd] if self.has_key? :ppd
  end
end