class QueryARPostWithCommentsWhereID
  def self.build(*args)
    new(*args)
  end 

  def query(post_id:)
    post_model = PostModel.where(id: post_id).first
    if post_model.nil?
      Struct.new(:success?).new(false)
    else
      Struct
        .new(:post, :comments)
        .new(post_model.rbrt, post_model.comments.map(&:rbrt))
    end
  end 
end
