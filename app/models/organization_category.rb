class OrganizationCategory < ActiveRecord::Base
  has_many :companies, :dependent => :destroy
end
