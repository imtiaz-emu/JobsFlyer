module JobsHelper
  def subscribed_companies
    companies = []
    active_subscriptions = current_user.companies.collect{|com| com.subscriptions.active_subscriptions}.flatten
    active_subscriptions.each do |subscription|
      if subscription.normal_job > 0 || subscription.feature_job > 0
        companies << subscription.company
      end
    end
    return companies.uniq
  end

  def job_location(company)
    company.city+', '+company.state+', '+Carmen::Country.coded(company.country).to_s
  end

  def range_values(object)
    [object.split(',')[0].to_i, object.split(',')[1].to_i]
  end

  def applied_users_dropresume_url(user)
    begin
      api_url = YAML.load_file('config/api_information.yml')['dropresume']['user'] + '?email=' + user.email
      user_response = HTTParty.get api_url
      @user_info = user_response.parsed_response
      return "http://dropresume.com/#{@user_info['user']}"
    rescue Exception => ex
      Rails.logger.error "Api load error: #{ex.message}"
      return "http://dropresume.com/"
    end
  end

  def full_user_name(applied_user)
    applied_user.profile.first_name + " " + applied_user.profile.last_name.to_s
  end
end
