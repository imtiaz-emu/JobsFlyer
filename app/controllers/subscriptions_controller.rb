class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :cannot_edit_active_subscriptions, :only => [:edit, :update]
  before_filter :load_companies

  layout 'dashboard'

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscription_tab = 'active'
    @subscriptions = current_user.companies.collect{|c| c.subscriptions}.flatten
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    if @user_companies.count > 0
      @subscription_tab = 'active'
      @subscription = Subscription.new
    else
      redirect_to companies_new_path, :flash => {notice: 'Please create a company first to buy any subscription.'}
    end
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        @subscription.price_calculate_and_save
        format.html { redirect_to subscription_path(@subscription), flash: {:success => 'Subscription was successfully created.'} }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        @subscription.price_calculate_and_save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, flash: {:notice => 'Subscription was successfully destroyed.'} }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_subscription
    @subscription_tab = 'active'
    @subscription = Subscription.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:company_id, :normal_job, :feature_job, :total_month, :discount, :total_amount, :bkash_transaction_no, :status)
  end

  def cannot_edit_active_subscriptions
    if ['pending', 'draft'].include?(@subscription.status) && @subscription.company.users.include?(current_user) #CompanyAdmin.where(:company_id => @subscription.company.id, :user_id => current_user.id).count > 0
      return true
    else
      redirect_to subscriptions_path(@subscription), flash: {:error => 'You cannot edit previously subscribed packages.'}
    end
  end

  def load_companies
    @user_companies = CompanyAdmin.where(:user_id => current_user.id, :user_role => 'admin' ).collect{|ca| ca.company}.flatten
  end
end
