class DashboardController < ApplicationController

  before_filter :authenticate_user!, :except => [:all_companies]
  layout 'dashboard'

  def index
    @dash_tab = 'active'
  end

  def calculate_price
    @normal_price = params[:normal_job].to_i * Subscription::NORMAL_JOB_PRICE
    @feature_price = params[:feature_job].to_i * Subscription::FEATURE_JOB_PRICE
    @month_price = params[:total_month].to_i * Subscription::PER_MONTH
    @total_price = @normal_price + @feature_price + @month_price
  end

  def job_locations
    @company_locations = Company.find(params[:company_id]).company_locations
  end

  def skills
    @skills = Skill.where("name ilike ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @skills.map(&:attributes) }
    end
  end

  def all_companies
    @company_tab = 'active'
    @companies = Company.all
  end

end
