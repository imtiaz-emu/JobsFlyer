class PageController < ApplicationController

  layout 'static_page'

  before_action :load_companies

  def load_companies
    @top_companies = Company.all.sort{|a,b| b.jobs.count <=> a.jobs.count}.first(24)
  end

end
