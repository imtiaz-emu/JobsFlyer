module CompaniesHelper
  def all_companies
    Company.all.collect{|c| c.slug}
  end

  def company_admin(company)
    current_user.present? && company.users.include?(current_user)
  end
end
