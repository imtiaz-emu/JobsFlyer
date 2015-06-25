class AppliedJobsController < ApplicationController

  def create
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['user'] + '?email=' + current_user.email
      # api_url = YAML.load_file('config/api_information.yml')['dropresume']['user'] + '?email=emu@bytelogistics.com' #+ current_user.email
      user_response = HTTParty.get api_url
      @user_info = blog_response.parsed_response
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      @user_info = []
    end
  end

end
