class Like < ActiveRecord::Base
  belongs_to  :likable, :polymorphic => true
  belongs_to :user
  attr_accessor :job_id, :post_id
end
