require "./app/domain/domain_builder"
require "./app/domain/type"

class User
  def self.build_attributes
    Rbrt::Attributes.build(full_name: "", created_at: nil)
  end

  def self.build_base
    DomainBuilder
      .build(new)
      .set_id
  end

  def self.build(attributes: build_attributes)
    build_base
      .set_attributes(attributes)
  end

  def full_name
  end

  def set_db_id(db_id)
    @db_id = db_id
    self
  end

  def db_id
    @db_id
  end

  def type
    Type.user
  end
end
