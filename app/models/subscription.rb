class Subscription < ActiveRecord::Base
  belongs_to :user

  scope :active_subscriptions, -> { where(status: 'active') }
  scope :pending_subscriptions, -> { where(status: 'pending') }
  scope :declined_subscriptions, -> { where(status: 'declined') }
  scope :expired_subscriptions, -> { where(status: 'expired') }
  scope :draft_subscriptions, -> { where(status: 'draft') }

  validates_presence_of :bkash_transaction_no

  NORMAL_JOB_PRICE = 1500
  FEATURE_JOB_PRICE = 3500
  PER_MONTH = 1500
end
