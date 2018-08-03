# frozen_string_literal: true

class Question < ApplicationRecord
  include Commentable
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  belongs_to :user
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments
  acts_as_votable
end
