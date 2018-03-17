class CommentModel < ApplicationRecord
  self.table_name = "comments"
  belongs_to :post, class_name: "PostModel"

  # text

  def self.association_names
    [:post]
  end

  def rbrt
    Comment
      .build
      .tap { |comment| comment.attributes.set(attributes.symbolize_keys) }
      .set_db_id(id)
  end
end
