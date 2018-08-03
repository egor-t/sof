# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook github]

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :authorizations
  has_many :subscriptions, dependent: :destroy

  def author_of?(resource)
    id == resource.user_id
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.find_by(provider: auth[:provider], uid: auth[:uid].to_s)
    return authorization.user if authorization

    email = auth.info.email if auth.info&.email
    user = User.where(email: email).first

    if user
      user.create_authorizations(auth)
    else
      password = Devise.friendly_token[0, 20]
      email ||= "zzzzz-#{auth.uid}@#{auth.provider}.com"
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_authorizations(auth)
    end
    user
  end

  def create_authorizations(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end

  def subscribed_for_question?(question)
    subscribtion_for_question(question)
  end

  def subscribtion_for_question(question)
    subscriptions.where(question_id: question).first
  end
end
