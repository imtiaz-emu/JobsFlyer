class SearchController < ApplicationController

  layout 'dashboard'

  def index
    @results = Job.quick_search(params[:q])
  end
end