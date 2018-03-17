class CommentsController < ApplicationController
  def create
    result = CommentCreateUseCase.call(current_user: nil,
                                       queries: queries,
                                       persistance: persistance,
                                       post_db_id: params[:post_id].presence,
                                       attributes: params.permit(:text).to_h.symbolize_keys)
    # TODO: present errors
    @presenter = result
  end 
end
