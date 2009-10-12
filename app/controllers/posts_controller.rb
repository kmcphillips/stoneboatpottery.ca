class PostsController < ApplicationController
  
  def index
    @posts = Post.all(:order => "updated_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    
    unless @post
      flash[:error] = "Could not find that post."
      redirect_to posts_path
    end
  end

end
