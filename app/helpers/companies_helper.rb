module CompaniesHelper
  def all_companies
    Company.all.collect{|c| c.slug}
  end
end
