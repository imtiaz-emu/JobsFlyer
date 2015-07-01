class SearchController < ApplicationController

  layout 'dashboard_widget'

  def index
    @results = Job.quick_search(params[:query])
    if params[:area].present?
      @results = @results.count == 0 ? Job.where(:job_location => params[:area]) : @results.where(:job_location => params[:area])
    end
  end

  def advance_search
    @search_tab = 'active'
    @jobs = Job.all
  end

  def advance_search_results
    @searched_jobs = Job.all
    @searched_jobs = @searched_jobs.where(:organization_category_id => params[:job_category_id].to_i) if params[:job_category_id].present?
    @searched_jobs = @searched_jobs.where('deadline > (?)', params[:deadline].to_date) if params[:deadline].present?
    @searched_jobs = @searched_jobs.where(:job_location => params[:job_location].to_i) if params[:job_location].present?
    @searched_jobs = @searched_jobs.joins(:skills).where('skill_id IN (?)', params[:job_skills].collect { |skill_id| skill_id.to_i }) if params[:job_skills] != ['']
    # @searched_jobs = @searched_jobs.where(:job_location => params[:job_location].to_i) if params[:job_location].present?
    return @searched_jobs
  end
end