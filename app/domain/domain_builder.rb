module DomainBuilder
  def self.build(domain_object)
    domain_object
      .extend(Rbrt::DomainAssociations)
      .extend(Rbrt::DomainAttributes)
      .extend(Rbrt::DomainID)
      .extend(Rbrt::DomainNotNull)
      .extend(Rbrt::DomainState)
      .extend(Rbrt::DomainUtils)
  end 
end
