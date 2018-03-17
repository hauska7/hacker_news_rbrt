class PostsController < ApplicationController
  def index
  end
  def create
    result = PostCreateUseCase.call(current_user: nil,
                                    persistance: persistance,
                                    attributes: params.permit(:title).to_h.symbolize_keys)
    # TODO: present errors
    @presenter = result
  end 

  def show
    result = PostShowUseCase.call(current_user: nil,
                                  queries: queries,
                                  post_db_id: params[:id].presence)
    @presenter = Struct.new(:post, :comments).new(result.post, result.post.comments)
  end 
end
