require "./app/domain/domain_builder"
require "./app/domain/type"

class Post
  def self.build_attributes
    Rbrt::Attributes.build(title: "", created_at: nil)
  end

  def self.build_base
    DomainBuilder
      .build(new)
      .build_has_many(name: :comments)
      .set_id
  end

  def self.build(attributes: build_attributes)
    build_base
      .set_attributes(attributes)
  end

  def title
    @attributes.title
  end

  def comments
    @associations.comments.get
  end

  def validate_create
    result = {}
    result[:title] = "Too long" if @attributes.title.size > 100
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
    Type.post
  end
end
