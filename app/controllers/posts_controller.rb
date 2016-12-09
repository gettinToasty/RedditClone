class PostsController < ApplicationController

  before_action :is_author_or_mod, only: [:update, :edit, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new

  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @sub = @post.sub
    @post.destroy
    redirect_to sub_url(@sub)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def is_author_or_mod
    @post = Post.find(params[:id])
    @sub = @post.sub
    unless current_user == @post.author || current_user == @sub.moderator
      flash[:errors] = ["Not permitted"]
      redirect_to post_url(@post)
    end
  end

end
