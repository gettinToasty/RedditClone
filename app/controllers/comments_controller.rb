class CommentsController < ApplicationController

  def new

  end

  def show
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.post_id)
    @all_comments = @post.comments_by_parent_id
    @votes = Vote.where(votable_id: params[:id], votable_type: Comment).sum(:value)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to post_url(params[:post_id])
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    Vote.create(value: 1, votable_id: @comment.id, votable_type: Comment)
    redirect_to comment_url(@comment)
  end

  def downvote
    @comment = Comment.find(params[:id])
    Vote.create(value: -1, votable_id: @comment.id, votable_type: Comment)
    redirect_to comment_url(@comment)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
