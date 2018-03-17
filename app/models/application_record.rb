class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # TODO
  # This is a bit ugly piece
  # Basicly we create rails models from our rbrt objects and their associations
  # It works ok with belongs_to but further work is needed to handle many to many
  # Also the belongs_to associations are coupled to saving object that defines them
  # It could be split possibly

  def self.build(regular)
    x = regular.attributes.to_hash.merge(id: regular.db_id).merge(associations(regular))
    new(x).tap do |regular_model|
      regular_model.instance_variable_set("@new_record", false) if regular_model.id
    end 
      .set_source(regular)
      .set_rbrt_changed_attributes(*x.keys)
  end 

  def self.associations(regular)
    regular
      .associations
      .select { |name, association| association_names.include?(name) }
      .select { |name, association| association.state.loaded? }
      .map do |name, association|
        [name.to_s.concat("_id").to_sym, association.active? ? association.get.db_id : nil]
      end 
        .to_h
  end 

  def set_source(source)
    @source = source
    self
  end 

  def light_save
    if new_record?
      save(validate: false)
    else
      update_columns(attributes.symbolize_keys.slice(*@rbrt_changed_attributes))
    end
    @source.set_db_id(id)
    self
  end

  def set_rbrt_changed_attributes(*attribute_names)
    @rbrt_changed_attributes = attribute_names
    self
  end
end
