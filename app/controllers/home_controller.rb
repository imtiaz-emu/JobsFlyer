class HomeController < ApplicationController
  layout 'dashboard_widget'
  def index
  end

  def load_states
    @country_code = params[:country_code]

    respond_to do |format|
      format.js
    end
  end

  def find_cities
    @cities = City.all
    @cities = @cities.where(:country_code => params[:c_code]) if params[:c_code].present?
    respond_to do |format|
      format.json {render json: @cities }
    end
  end

  def load_cities
    @cities = City.where("name ilike ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @cities.map(&:attributes) }
    end
  end
end
