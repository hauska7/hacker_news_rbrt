class PostModel < ApplicationRecord
  self.table_name = "posts"
  has_many :comments, class_name: "CommentModel", foreign_key: :post_id

  # title

  def self.association_names
    []
  end

  def rbrt
    Post
      .build
      .tap { |post| post.attributes.set(attributes.symbolize_keys) }
      .set_db_id(id)
  end
end
