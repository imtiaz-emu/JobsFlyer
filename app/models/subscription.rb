class Subscription < ActiveRecord::Base
  belongs_to :company

  scope :active_subscriptions, -> { where(status: 'active') }
  scope :pending_subscriptions, -> { where(status: 'pending') }
  scope :declined_subscriptions, -> { where(status: 'declined') }
  scope :expired_subscriptions, -> { where(status: 'expired') }
  scope :draft_subscriptions, -> { where(status: 'draft') }

  validates_presence_of :bkash_transaction_no

  FREE_COUPON = true
  FREE_COUPON_BKASH_TRANSACTION = '123123123123'
  NORMAL_JOB_PRICE = FREE_COUPON ? 0 : 1500
  FEATURE_JOB_PRICE = FREE_COUPON ? 0 : 3500
  PER_MONTH = FREE_COUPON ? 0 : 1500

  def price_calculate_and_save
    calculation = self.feature_job.to_f * FEATURE_JOB_PRICE.to_f + self.normal_job.to_f * NORMAL_JOB_PRICE.to_f + self.total_month.to_f * PER_MONTH.to_f
    self.total_amount = calculation
    self.save(:validate => false)
  end
end
