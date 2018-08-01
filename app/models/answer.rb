# frozen_string_literal: true

class Answer < ApplicationRecord
  include Commentable

  has_many :attachments, as: :attachable
  belongs_to :question
  belongs_to :user


  accepts_nested_attributes_for :attachments

  validates :body, presence: true

  acts_as_votable

  scope :sorted_by_best_answer, -> { order(best_answer: :desc) }

  after_create :send_email_to_question_author, if: Proc.new { self.question.user.subscribed_for_question?(self.question) }
  after_create :send_email_to_question_subscribers

  def set_all_answers_not_best!
    Answer.update_all(best_answer: false)
  end

  protected

  def send_email_to_question_author
    NewAnswerJob.perform_later(self)
  end

  def send_email_to_question_subscribers
    SubscribedQuestionJob.perform_later(self)
  end
end
