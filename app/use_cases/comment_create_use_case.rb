require "./app/domain/comment"

class CommentCreateUseCase
  def self.call(*args)
    new(*args).call
  end

  def initialize(queries:, persistance:, current_user:, post_db_id:, attributes:)
    @queries = queries
    @persistance = persistance
    @current_user = current_user
    @post_db_id = post_db_id
    @attributes = attributes
  end

  def call
    @post = @queries.post_where_id(post_id: @post_db_id).post
    @comment = Comment.build
    @comment.attributes.set(@attributes)
    #@post.can_add_comment(@comment)
    @comment.a.post.associate(@post.a.comments).state.set_loaded
    @errors = @comment.validate_create
    if @errors.empty?
      @persistance.add(@post, @comment)
      @persistance.persist
    end
    Struct
      .new(:current_user, :comment, :success?,      :errors)
      .new(@current_user, @comment, @errors.empty?, @errors)
  end
end
