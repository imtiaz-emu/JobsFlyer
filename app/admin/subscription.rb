ActiveAdmin.register Subscription do
  config.clear_action_items!
  actions :index

  member_action :active do
    @subscription = Subscription.find(params[:id])
    @subscription.status = 'active'
    @subscription.save
    redirect_to :back
  end

  member_action :pending do
    @subscription = Subscription.find(params[:id])
    @subscription.status = 'pending'
    @subscription.save
    redirect_to :back
  end

  member_action :decline do
    @subscription = Subscription.find(params[:id])
    @subscription.status = 'declined'
    @subscription.save
    redirect_to :back
  end

  index do
    selectable_column
    column :id
    column 'User' do |sub|
      sub.company.name
    end
    column 'Non featured job' do |sub|
      sub.normal_job
    end
    column 'featured job' do |sub|
      sub.feature_job
    end
    column 'Search expires' do |sub|
      (sub.created_at + sub.total_month.months).to_date
    end
    column 'Amount Paid' do |sub|
      sub.total_amount
    end
    column 'Bkash Transaction no.' do |sub|
      sub.bkash_transaction_no
    end
    column 'Current Status' do |sub|
      sub.status
    end
    actions do |subscription|
      link_to('Active', active_admin_subscription_path(subscription))
    end

    actions do |subscription|
      link_to('Decline', decline_admin_subscription_path(subscription))
    end

    actions do |subscription|
      link_to('Pending', pending_admin_subscription_path(subscription))
    end

  end

end
