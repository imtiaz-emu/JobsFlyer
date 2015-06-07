class OrganizationCategory < ActiveRecord::Base
  has_many :companies, :dependent => :destroy
  has_many :jobs
end
