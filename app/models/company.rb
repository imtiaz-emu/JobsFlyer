class Company < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :user

  mount_uploader :logo, ProfileUploader
  mount_uploader :bg_image, ProfileUploader

  extend FriendlyId
  friendly_id :web_address, use: :slugged

  validates_presence_of :name, :organization_category_id, :logo, :bg_image, :web_address

  EMPLOYEE_RANGE = ['1-5', '6-15', '16-30', '30-50', '50+']
end
