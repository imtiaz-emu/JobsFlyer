module SubscriptionsHelper
  def month_list
    (1..12).collect{|i| i.to_s+' month'}
  end

  def subscription_status(sub)
    case sub.status
      when 'pending'
        return 'info'
      when 'active'
        return 'success'
      when 'declined'
        return 'danger'
      else
        return 'warning'
    end
  end

  def remaining_normal_jobs(subscription)
    ((subscription.normal_job - subscription.company.jobs.normal_jobs.count).to_f/subscription.normal_job.to_f)*100.0
  end

  def remaining_featured_jobs(subscription)
    ((subscription.feature_job - subscription.company.jobs.featured_jobs.count).to_f/subscription.feature_job.to_f)*100.0
  end

  def remaining_search_period(subscription)

  end
end
