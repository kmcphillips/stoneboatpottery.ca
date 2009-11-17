class Admin::PostsController < ApplicationController
  before_filter :require_login
  
  def index
    @posts = Post.all(:order => "updated_at DESC")
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
    @title = "Edit Post"
  end
  
  def create
    @post = Post.new(params[:post])
    
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
    
    if @post.update_attributes(params[:post])
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
  
end
