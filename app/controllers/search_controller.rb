# frozen_string_literal: true

class SearchController < ApplicationController
  skip_authorization_check

  before_action :set_data, only: :index

  respond_to :html

  def index
    return unless @query
    @search_result = @object.search(@query)
    flash.now[:success] = 'Search result!'
  end

  private

  def set_data
    @object = params[:object_type].constantize if params[:object_type]
    @query = params[:query]
  end
end
