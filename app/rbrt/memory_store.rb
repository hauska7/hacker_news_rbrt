class MemoryStore
  def self.build
    new 
  end 

  def initialize
    @store = Set.new
  end 

  def add(*objects)
    objects.each { |object| @store << object }
    self
  end 

  def clear
    @store = Set.new
  end 

  def users
    @store.select { |object| Type.user?(object) }
  end 

  def posts
    @store.select { |object| Type.post?(object) }
  end 

  def comments
    @store.select { |object| Type.comment?(object) }
  end 
end
