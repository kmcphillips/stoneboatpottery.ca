class Admin::PostsController < AuthenticatedController

  def index
    @posts = Post.order("created_at DESC")
    @title = "Posts"
  end

  def show
    @post = Post.find_by_permalink(params[:id])

    redirect_to post_path(@post)
  end

  def new
    @post = Post.new
    @title = "New Post"
  end

  def edit
    @post = Post.find_by_permalink(params[:id])

    if @post.system?
      flash[:error] = "Cannot edit system generated posts."
      redirect_to admin_posts_path
    else
      @title = "Edit Post"
    end
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Post successfully created."
      redirect_to admin_posts_path
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render 'admin/posts/new'
    end
  end

  def update
    @post = Post.find_by_permalink(params[:id])

    if @post.system?
      flash[:error] = "Cannot edit system generated posts."
      redirect_to admin_posts_path
    elsif @post.update_attributes(post_params)
      flash[:notice] = "Post successfully updated."
      redirect_to admin_posts_path
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render 'admin/posts/edit'
    end
  end

  def destroy
    @post = Post.find_by_permalink(params[:id])

    if @post.delete
      flash[:notice] = "Post deleted."
    else
      flash[:error] = @post.errors.full_messages.to_sentence
    end

    redirect_to admin_posts_path
  end

  private

  def post_params
    params.permit![:post]
  end
end
