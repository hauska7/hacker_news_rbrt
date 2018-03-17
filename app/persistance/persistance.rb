require "./app/rbrt/memory_store"                                                                                                             

class Persistance
  def self.build
    new 
  end 

  def initialize
    @store = MemoryStore.build
  end 

  def empty_copy
    Persistance.build
  end 

  def add(*objects)
    @store.add(*objects)
    self
  end 

  def persist
    ActiveRecord::Base.transaction do
      @store.posts
            .select { |post| !post.state.destroyed? }
            .each { |post| persist_post(post) }
            .each { |post| persist_post_associations(post) }
            .size
      @store.posts
            .select { |post| post.state.destroyed? }
            .each { |post| delete_post(post) }
            .size
      @store.comments
            .select { |comment| !comment.state.destroyed? }
            .each { |comment| persist_comment(comment) }
            .each { |comment| persist_comment_associations(comment) }
            .size
      @store.comments
            .select { |comment| comment.state.destroyed? }
            .each { |comment| delete_comment(comment) }
            .size
    end
    Struct.new(:success?).new(true)
  end

  def persist_post(post)
    PostModel.build(post).light_save
    self
  end

  def persist_post_associations(post)
    self
  end

  def delete_post(post)
    PostModel
      .build(post)
      .delete
    self
  end

  def persist_comment(comment)
    CommentModel.build(comment).light_save
    self
  end

  # currently comment -> parent post association is being persisted togeather with comment model
  def persist_comment_associations(comment)
    self
  end

  def delete_comment(comment)
    CommentModel
      .build(comment)
      .delete
    self
  end
end
