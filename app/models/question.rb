# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  belongs_to :user

  validates :title, :body, presence: true


  accepts_nested_attributes_for :attachments
  acts_as_votable
end
