class QueryPostWhereIDDouble
  def self.build(*args)
    new(*args)
  end 

  def initialize(post:)
    @post = post
    self
  end 

  def query(post_id:)
    fail "query not mocked" unless post_id == @post.db_id

    Struct.new(:post).new(@post)
  end 
end
