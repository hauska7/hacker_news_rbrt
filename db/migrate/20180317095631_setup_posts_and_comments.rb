class SetupPostsAndComments < ActiveRecord::Migration[5.0]
  def change
    create_table "posts", force: :cascade do |t| 
      t.string   "title",       null: false
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end 

    create_table "comments", force: :cascade do |t|    
      t.string   "text",               null: false
      t.datetime "created_at",         null: false
      t.datetime "updated_at",         null: false
    end 
    add_reference(:comments, :post, index: true, null: false)
    add_foreign_key(:comments, :posts, column: :post_id)
  end
end
