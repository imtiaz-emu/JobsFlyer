class SavedLink < ActiveRecord::Base
  belongs_to  :saveable, :polymorphic => true
  belongs_to :user
  attr_accessor :job_id, :post_id
end
