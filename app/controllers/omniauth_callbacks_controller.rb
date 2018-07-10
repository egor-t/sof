class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user

  def facebook
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  def github
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    end
  end
  private

  def set_user
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end
end
