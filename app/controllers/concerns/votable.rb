module Votable
  extend ActiveSupport::Concern


  included do
    before_action :set_votable, only: [:like, :dislike]
    before_action :can_vote?, only: [:like, :dislike]
  end

  def like
    @votable.like_by(current_user)

    respond_to do |format|
      format.json { render json: { data: @votable.get_likes.size }  }
    end
  end

  def dislike
    @votable.dislike_by(current_user)

    respond_to do |format|
      format.json { render json:  { data: @votable.get_dislikes.size } }
    end
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end

  def can_vote?
    if current_user.author_of?(@votable)
      render json: { error: "Author can't vote for own question" }, status: :forbidden
    end
  end
end