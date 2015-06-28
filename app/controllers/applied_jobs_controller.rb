class AppliedJobsController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard'

  def index
    @jobs = current_user.jobs
    @jobs_tab = 'active'
  end

  def create
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['user'] + '?email=' + current_user.email
      user_response = HTTParty.get api_url
      @user_info = user_response.parsed_response
      if @user_info['notice'].present?
        redirect_to job_path(params[:job_id]), flash: {:notice => @user_info['notice']}
      else
        job = Job.friendly.find(params[:job_id])
        current_user.jobs << job
        redirect_to job_path(params[:job_id]), flash: {:success => "You've successfully applied for this job."}
      end
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      redirect_to job_path(params[:job_id]), flash: {:error => "API load error!"}
    end
  end

end
