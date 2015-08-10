class JobsUser < ActiveRecord::Base
  belongs_to :job
  belongs_to :user
  has_many :likes, as: :likable, :dependent => :destroy
end
