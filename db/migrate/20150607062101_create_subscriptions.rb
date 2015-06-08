class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer       :company_id
      t.integer       :normal_job
      t.integer       :feature_job
      t.integer       :total_month
      t.string        :status, :default => 'pending'
      t.float         :discount
      t.float         :total_amount
      t.string        :bkash_transaction_no

      t.timestamps null: false
    end
  end
end
