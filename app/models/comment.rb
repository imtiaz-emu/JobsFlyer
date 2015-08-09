class Comment < ActiveRecord::Base

  belongs_to  :commentable, :polymorphic => true
  belongs_to :user
  attr_accessor :job_id, :post_id

end
