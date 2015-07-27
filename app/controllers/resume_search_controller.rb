class ResumeSearchController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_has_subscription

  layout 'dashboard_widget'

  def index
    @res_search_tab = 'active'
    @jobs = current_user.companies.collect { |com| com.jobs }.flatten
  end

  def search_results
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['resumes'] + "?skills=#{params[:skills]}" + "&age=#{params[:age]}" + "&experience=#{params[:experience]}"
      user_response = HTTParty.get (URI.encode(api_url))
      @user_resumes = user_response.parsed_response
      # @user_resumes = @user_resumes['user_resumes']
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      # redirect_to job_path(params[:job_id]), flash: {:error => "API load error!"}
    end
  end

  def add_remove_from_bank
    resume_saved = current_user.saved_resumes.find_by_job_seeker_email(params[:email])
    if resume_saved.present?
      resume_saved.destroy
    else
      current_user.saved_resumes.create(:job_seeker_email => params[:email])
    end
    render :nothing => true
  end

  def my_resume_bank
    @res_search_tab = 'active'
    @my_saved_resumes = []
    begin
      current_user.saved_resumes.each do |resume|
        api_url = YAML.load_file('config/api_information.yml')['dropresume']['user_details'] + "?email=#{resume.job_seeker_email}"
        user_response = HTTParty.get (URI.encode(api_url))
        @my_saved_resumes << user_response.parsed_response
      end
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
    end
  end

  def destroy_saved_resume
    SavedResume.find(params[:id]).destroy
    redirect_to my_resume_bank_path, flash: {notice: 'Successfully deleted saved resume.'}
  end

  private
  def check_has_subscription
    active_subscriptions = current_user.companies.collect{|com| com.subscriptions.active_subscriptions}.flatten
    if active_subscriptions.count > 0
      active_subscriptions.each do |subscription|
        if (subscription.updated_at + subscription.total_month.months) >= Date.today
          return true
        end
      end
      redirect_to dashboard_path, flash: {:notice => "You're search for resume period expired. Please re-subscribe!"}
    else
      redirect_to new_subscription_path, flash: {:error => "You've no active subscriptions. Please subscribe!"}
    end
  end
end
