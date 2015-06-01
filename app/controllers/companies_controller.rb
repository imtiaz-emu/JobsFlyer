class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :update_your_profile
  before_filter :user_verify_on_edit, :only => [:edit, :update]

  layout 'dashboard'
  # GET /companies
  # GET /companies.json
  def index
    @companies = current_user.companies
    @company_tab = 'active'
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company_tab = 'active'
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    params[:company][:user_id] = current_user.id
    # params[:company][:web_address] = params[:company][:web_address].gsub!(/\W/,'')
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    params[:company][:user_id] = current_user.id
    # params[:company][:web_address] = params[:company][:web_address].gsub!(/\W/,'')
    respond_to do |format|
      if @company.update_attributes(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def availability
    if params[:slug].length < 5 || Company.friendly.exists?(params[:slug])
      @availability = false
    else
      @availability = true
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.friendly.find(params[:id])
      @company_tab = 'active'
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:organization_category_id, :user_id, :name, :logo, :bg_image, :description, :employee_range, :website, :web_address)
    end

    def user_verify_on_edit
      unless Company.friendly.find(params[:id]).user == current_user
        redirect_to user_companies_path(current_user), notice: "You're trying to modify other user's company!"
      end
    end

end
