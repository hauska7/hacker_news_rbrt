require "./app/rbrt/memory_store"

class PersistanceDouble
  def self.build
    new 
  end

  def initialize
    @persist_count = 0 
    @user_persisted_count = 0 
    @post_persisted_count = 0 
    @comment_persisted_count = 0 
    @associations_persisted_count = 0 
    @store = MemoryStore.build
  end 

  def empty_copy
    PersistanceDouble.build
  end 

  attr_reader :persist_count,
              :user_persisted_count,
              :post_persisted_count,
              :comment_persisted_count,
              :post_destroyed_count,
              :associations_persisted_count

  def add(*objects)
    @store.add(*objects)
    self
  end

  def clear
    @store.clear
    self
  end

  def persist
    @persist_count += 1
    @user_persisted_count = @store.users
                                  .select { |user| !user.state.destroyed? }
                                  .each { |user| persist_user(user) }
                                  .size
    @post_destroyed_count = @store.posts
                                  .select { |post| post.state.destroyed? }
                                  .size
    @post_persisted_count = @store.posts
                                  .select { |post| !post.state.destroyed? }
                                  .each { |post| persist_post(post) }
                                  .each { |post| persist_post_associations(post) }
                                  .size
    @comment_persisted_count = @store.comments
                                     .select { |comment| !comment.state.destroyed? }
                                     .each { |comment| persist_comment(comment) }
                                     .each { |comment| persist_comment_associations(comment) }
                                     .size
  end

  def persist_user(user)
    if user.db_id.nil?
      user.set_db_id(sequence_db_id_next_user)
          .tap { |user| user.attributes.set(created_at: Time.now) }
    else
      user
    end
  end

  def persist_post(post)
    if post.db_id.nil?
      post.set_db_id(sequence_db_id_next_post)
          .tap { |post| post.attributes.set(created_at: Time.now) }
    else
      post
    end
  end

  def persist_post_associations(post)
    @associations_persisted_count += post.associations.length
  end

  def persist_comment(comment)
    if comment.db_id.nil?
      comment.set_db_id(sequence_db_id_next_comment)
             .tap { |comment| comment.attributes.set(created_at: Time.now) }
    else
      comment
    end
  end

  def persist_comment_associations(comment)
    @associations_persisted_count += comment.associations.length
  end

  def sequence_db_id_next_user
    @sequence_db_id_next_user ||= 0
    @sequence_db_id_next_user += 1
  end

  def sequence_db_id_next_post
    @sequence_db_id_next_post ||= 0
    @sequence_db_id_next_post += 1
  end

  def sequence_db_id_next_comment
    @sequence_db_id_next_comment ||= 0
    @sequence_db_id_next_comment += 1
  end
end
