module CompaniesHelper
  def all_companies
    Company.all.collect{|c| c.slug}
  end

  def company_admin(company)
    current_user.present? && company.users.include?(current_user)
  end

  def is_a_company_follower(company)
    company.followers.collect{|f| f.user_id}.include?(current_user.id)
  end
end
