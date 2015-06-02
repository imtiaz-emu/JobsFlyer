module ApplicationHelper
  def is_company_admin(company)
    admins = company.company_admins.where(:user_role => 'admin')
    if admins.count > 0
      admins.collect{|a| a.user_id}.include?(current_user.id)
    else
      false
    end
  end
end
