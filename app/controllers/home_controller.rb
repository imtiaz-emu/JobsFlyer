class HomeController < ApplicationController
  def index
  end

  def load_states
    @country_code = params[:country_code]

    respond_to do |format|
      format.js
    end
  end
end
