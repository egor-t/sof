# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can %i[create update destroy], [Question, Answer], user: user
      can :create, Comment
      can :best_answer, Answer, user: user
      cannot %i[like dislike], [Question, Answer], user: user
      can %i[like dislike], [Question, Answer]
      can :manage, Attachment
    end

    can :read, :all
  end
end
