require "my_spec_helper"
require "./app/use_cases/post_show_use_case"
require "./app/domain/user"
require "./app/domain/post"
require "./app/domain/comment"
require "./app/queries/queries"
require "./spec/doubles/persistance_double"
require "./spec/doubles/query_post_with_comments_where_id_double"

RSpec.describe PostShowUseCase do
  it "success" do
    persistance = PersistanceDouble.build
    current_user = User.build
    post = Post.build.tap { |p| p.attributes.set(title: "Best Board Games") }
    got_comment = Comment.build.tap { |p| p.attributes.set(text: "Game Of Thrones") }
    settlers_comment = Comment.build.tap { |p| p.attributes.set(text: "Settlers Of Catan") }
    persistance.add(post, got_comment, settlers_comment)
    persistance.persist
    persistance.clear
    queries = Queries.build
              .set_query_post_with_comments_where_id(
                query: QueryPostWithCommentsWhereIDDouble.build(post: post, comments: [got_comment, settlers_comment])
              )

    result = PostShowUseCase.call(queries: queries,
                                  current_user: current_user,
                                  post_db_id: post.db_id)
    
    expect(result.post.db_id).to eq post.db_id
    expect(result.post.comments.size).to eq 2
  end 
end
