require "./app/domain/post"

class PostCreateUseCase
  def self.call(*args)
    new(*args).call
  end

  def initialize(persistance:, current_user:, attributes:)
    @persistance = persistance
    @current_user = current_user
    @attributes = attributes
  end

  def call
    @post = Post.build
    @post.attributes.set(@attributes)
    @errors = @post.validate_create
    if @errors.empty?
      @persistance.add(@post)
      @persistance.persist
    end
    Struct
      .new(:current_user, :post, :success?,      :errors)
      .new(@current_user, @post, @errors.empty?, @errors)
  end
end
