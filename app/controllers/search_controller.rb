class SearchController < ApplicationController

  layout 'dashboard'

  def index
    @results = Job.quick_search(params[:query])
    if params[:area].present?
      @results = @results.count == 0 ? Job.where(:job_location => params[:area]) : @results.where(:job_location => params[:area])
    end
  end
end