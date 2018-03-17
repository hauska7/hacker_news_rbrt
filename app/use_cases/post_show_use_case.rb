class PostShowUseCase
  def self.call(*args)
    new(*args).call
  end

  def initialize(queries:, current_user:, post_db_id:)
    @queries = queries
    @current_user = current_user
    @post_db_id = post_db_id
  end

  def call
    @post = @queries.post_with_comments_where_id(post_id: @post_db_id).post
    Struct
      .new(:current_user, :post, :success?)
      .new(@current_user, @post, true)
  end
end
