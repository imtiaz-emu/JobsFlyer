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
end
