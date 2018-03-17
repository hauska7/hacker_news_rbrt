class QueryARPostWhereID
  def self.build(*args)
    new(*args)
  end 

  def query(post_id:)
    Struct
      .new(:post)
      .new(PostModel.where(id: post_id).first&.rbrt)
  end 
end
