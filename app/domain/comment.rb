require "./app/domain/domain_builder"
require "./app/domain/type"

class Comment
  def self.build_attributes
    Rbrt::Attributes.build(text: "", created_at: nil)
  end

  def self.build_base
    DomainBuilder
      .build(new)
      .build_has_one(name: :post)
      .set_id
  end

  def self.build(attributes: build_attributes)
    build_base
      .set_attributes(attributes)
  end

  def text
    @attributes.text
  end

  def validate_create
    result = {}
    result[:text] = "Too long" if @attributes.text.size > 100
    result
  end

  def set_db_id(db_id)
    @db_id = db_id
    self
  end

  def db_id
    @db_id
  end

  def type
    Type.comment
  end
end
