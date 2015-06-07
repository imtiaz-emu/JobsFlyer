class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :cannot_edit_active_subscriptions, :only => [:edit, :update]

  layout 'dashboard'

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscription_tab = 'active'
    @subscriptions = current_user.subscriptions
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription_tab = 'active'
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    params[:subscription][:user_id] = params[:user_id]
    params[:subscription][:total_amount] = params[:subscription][:total_month].to_f * Subscription::PER_MONTH.to_f
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to user_subscription_path(@subscription.user,@subscription), flash: {:success => 'Subscription was successfully created.'} }
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
      params.require(:subscription).permit(:user_id, :normal_job, :feature_job, :total_month, :discount, :total_amount, :bkash_transaction_no, :status)
    end

    def cannot_edit_active_subscriptions
      if ['pending', 'draft'].include?(@subscription.status) && @subscription.user == current_user
        redirect_to edit_user_subscription_path(current_user, @subscription)
      else
        redirect_to user_subscriptions_path(current_user), flash: {:error => 'You cannot edit previously subscribed packages.'}
      end
    end
end
