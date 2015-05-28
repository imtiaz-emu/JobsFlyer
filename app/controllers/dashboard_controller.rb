class DashboardController < ApplicationController

  before_filter :authenticate_user!
  layout 'dashboard'

  def index
    @dash_tab = 'active'
  end
end
