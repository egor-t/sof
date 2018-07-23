class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :publish_comment, only: [:create]

  authorize_resource

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.json { render json: @comment.attributes.merge({ user_email: @comment.user.email }).to_json }
      else
        format.json { render json: @comment.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  private

  def publish_comment
    ActionCable.server.broadcast(
        'comments',
        comment: @comment.attributes.merge({ user_email: @comment.user.email }).to_json
    )
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
