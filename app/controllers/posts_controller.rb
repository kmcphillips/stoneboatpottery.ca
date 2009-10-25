class PostsController < ApplicationController
  
  def index
    # TODO: pagination
    @posts = Post.all(:order => "updated_at DESC")
  end

  def show
    @post = Post.find_by_permalink(params[:id])    

    unless @post
      flash[:error] = "Could not find that post."
      redirect_to posts_path
    end

    @title = @post.title
  end

  def archive
    @posts = Post.all(:order => "updated_at DESC")
  end

  def rss
    @posts = Post.all(:order => "updated_at DESC")
    
    respond_to do |wants|
      wants.xml do
        render :layout => false
      end
    end
  end

end
