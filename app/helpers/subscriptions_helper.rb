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
end
