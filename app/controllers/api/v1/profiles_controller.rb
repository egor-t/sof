class Api::V1::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!

  skip_authorization_check

  respond_to :json

  def me
    respond_with current_resource_owner
  end

  def index
    respond_with(@profiles = User.where.not(id: current_resource_owner.id))  if doorkeeper_token
  end

  protected

  def current_resource_owner
    @user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end