module Type
  def self.user
    :user
  end 

  def self.user?(object)
    object.type == :user
  end 

  def self.post
    :post
  end 

  def self.post?(object)
    object.type == :post
  end 

  def self.comment
    :comment
  end 

  def self.comment?(object)
    object.type == :comment
  end 
end
