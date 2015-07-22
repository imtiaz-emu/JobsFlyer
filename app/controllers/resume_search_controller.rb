class ResumeSearchController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_has_subscription

  layout 'dashboard_widget'

  def index
    @res_search_tab = 'active'
  end

  def search_results
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['resumes'] + "?skills=#{params[:skills]}" + "&age=#{params[:age]}" + "&experience=#{params[:experience]}"
      user_response = HTTParty.get api_url
      @user_resumes = user_response.parsed_response
      # @user_resumes = @user_resumes['user_resumes']
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      # redirect_to job_path(params[:job_id]), flash: {:error => "API load error!"}
    end
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
