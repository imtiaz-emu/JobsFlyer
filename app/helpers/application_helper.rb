module ApplicationHelper
  def is_company_admin(company)
    admins = company.company_admins.where(:user_role => 'admin')
    if admins.count > 0
      admins.collect{|a| a.user_id}.include?(current_user.id)
    else
      false
    end
  end

  def bootstrap_class_for flash_type
    { "success" => "alert-success", "error" => "alert-danger", "alert" => "alert-warning", "notice" => "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
               concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
               concat message
             end)
    end
    nil
  end

  def user_jobs
    current_user.companies.collect { |company| company.jobs }.flatten
  end

end
