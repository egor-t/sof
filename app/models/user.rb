# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :github]

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :authorizations

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
      email = email ? email : "zzzzz-#{auth.uid}@#{auth.provider}.com"
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.create_authorizations(auth)
    end
    user
  end

  def create_authorizations(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end
end
