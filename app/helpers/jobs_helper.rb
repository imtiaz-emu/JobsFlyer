module JobsHelper
  def subscribed_companies
    companies = []
    active_subscriptions = current_user.companies.collect{|com| com.subscriptions.active_subscriptions}.flatten
    active_subscriptions.each do |subscription|
      if subscription.normal_job > 0 || subscription.feature_job > 0
        companies << subscription.company
      end
    end
    return companies
  end

  def job_location(company)
    company.city+', '+company.state+', '+Carmen::Country.coded(company.country).to_s
  end

  def range_values(object)
    [object.split(',')[0].to_i, object.split(',')[1].to_i]
  end
end
