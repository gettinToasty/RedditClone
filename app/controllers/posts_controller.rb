class PostsController < ApplicationController

  before_action :is_author_or_mod, only: [:update, :edit, :destroy]

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    @votes = Vote.where(votable_id: params[:id], votable_type: Post).sum(:value)
  end

  def new
    @subs = Sub.all
  end

  def create
    @subs = Sub.all
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save!
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
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
    @post.destroy
    redirect_to root_url
  end

  def upvote
    @post = Post.find(params[:id])
    Vote.create(value: 1, votable_id: @post.id, votable_type: Post)
    redirect_to post_url(@post)
  end

  def downvote
    @post = Post.find(params[:id])
    Vote.create(value: -1, votable_id: @post.id, votable_type: Post)
    redirect_to post_url(@post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def is_author_or_mod
    @post = Post.find(params[:id])
    unless current_user == @post.author || current_user == @post.moderator
      flash[:errors] = ["Not permitted"]
      redirect_to post_url(@post)
    end
  end

end
