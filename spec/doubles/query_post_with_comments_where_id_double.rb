class QueryPostWithCommentsWhereIDDouble
  def self.build(*args)
    new(*args)
  end 

  def initialize(post:, comments:)
    @post = post
    @comments = comments
    self
  end 

  def query(post_id:)
    fail "query not mocked" unless post_id == @post.db_id

    Struct.new(:post, :comments).new(@post, @comments)
  end 
end
