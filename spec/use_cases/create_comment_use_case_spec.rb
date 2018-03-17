require "my_spec_helper"
require "./app/use_cases/comment_create_use_case"
require "./app/domain/user"
require "./app/domain/post"
require "./app/queries/queries"
require "./spec/doubles/persistance_double"
require "./spec/doubles/query_post_where_id_double"

RSpec.describe CommentCreateUseCase do
  it 'success' do
    persistance = PersistanceDouble.build
    current_user = User.build
    post = Post.build.tap { |p| p.attributes.set(title: "Best Board Games") }
    persistance.add(post)
    persistance.persist
    persistance.clear
    queries = Queries
              .build
              .set_query_post_where_id(
                query: QueryPostWhereIDDouble.build(post: post)
              )

    result = CommentCreateUseCase.call(queries: queries,
                                       persistance: persistance,
                                       current_user: current_user,
                                       post_db_id: post.db_id,
                                       attributes: { text: "Game Of Thrones" })
    
    expect(result.comment.text).to eq "Game Of Thrones"
    expect(persistance.comment_persisted_count).to eq 1
    expect(persistance.associations_persisted_count).to eq 3
  end 
end
