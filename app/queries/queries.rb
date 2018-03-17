# A query should in order:                                                                                                                    
# - fetch data from data source, usually eighter all attributes per object or just an id
# - build objects from data
# - check if any fetched objects are already used in application
# - associate most recent versions of objects
# - provide access to query result and if nessesary:
# -- all found recent objects eg. to add to persistance
# -- out of date objects

class Queries
  def self.build(db_objects_in_memory: Rbrt::DBObjectsInMemory.build)
    new(db_objects_in_memory: db_objects_in_memory)
  end

  def initialize(db_objects_in_memory:)
    @db_objects_in_memory = db_objects_in_memory
    @query_post_where_id = nil
    @query_post_with_comments_where_id = nil
  end

  attr_reader :db_objects_in_memory

  def set_query_post_where_id(query:)
    @query_post_where_id = query
    self
  end

  def set_query_post_with_comments_where_id(query:)
    @query_post_with_comments_where_id = query
    self
  end

  def post_where_id(*args)
    query = @query_post_where_id.query(*args)
    post = db_objects_in_memory.get(query.post).recent
    Struct.new(:post).new(post)
  end

  def post_with_comments_where_id(*args)
    query = @query_post_with_comments_where_id.query(*args)
    post = db_objects_in_memory.get(query.post).recent
    comments = query
               .comments
               .map { |comment| db_objects_in_memory.get(comment).recent }
    comments.each do |comment|
      post.a.comments.associate(comment.a.post)
    end
    Struct.new(:post).new(post)
  end
end
