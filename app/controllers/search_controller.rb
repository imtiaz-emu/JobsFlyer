class SearchController < ApplicationController

  layout 'dashboard_widget'

  def index
    if params[:area].present?
      city_name = City.find(params[:area]).name
      @company_location = CompanyLocation.where('city ilike ?', "%#{city_name}%").first
    end
    @results = Job.quick_search(params[:query])
    if @company_location.present?
      @results = @results.count == 0 ? Job.where(:job_location => @company_location.id) : @results.where(:job_location => @company_location.id)
      @results = @results.active_jobs
    end
  end

  def advance_search
    @search_tab = 'active'
    @jobs_tab = 'active'
    if params[:job_category].present?
      @job_category = JobCategory.find(params[:job_category].to_i)
      @jobs = @job_category.jobs.active_jobs.order(featured_job: :desc, created_at: :desc)
    else
      @jobs = Job.active_jobs.order(featured_job: :desc, created_at: :desc)
    end
  end

  def advance_search_results
    @searched_jobs = Job.active_jobs
    @searched_jobs = @searched_jobs.where(:job_category_id => params[:job_category_id].to_i) if params[:job_category_id].present?
    @searched_jobs = @searched_jobs.where('deadline > (?)', params[:deadline].to_date) if params[:deadline].present?
    @searched_jobs = @searched_jobs.where(:job_location => params[:job_location].to_i) if params[:job_location].present?
    @searched_jobs = @searched_jobs.joins(:skills).where('skill_id IN (?)', params[:job_skills].collect { |skill_id| skill_id.to_i }) if params[:job_skills] != ['']
    @searched_jobs = @searched_jobs.where(:featured_job => true) if params[:featured_job] == '1'
    return @searched_jobs
  end
end