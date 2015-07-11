class ResumeSearchController < ApplicationController

  layout 'dashboard_widget'

  def index
    @res_search_tab = 'active'
  end

  def search_results
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['resumes'] + "?skills=" + params[:skills]
      user_response = HTTParty.get api_url
      @user_resumes = user_response.parsed_response
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      # redirect_to job_path(params[:job_id]), flash: {:error => "API load error!"}
    end
  end
end
