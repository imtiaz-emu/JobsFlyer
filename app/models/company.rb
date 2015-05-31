class Company < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :user

  mount_uploader :logo, ProfileUploader
  mount_uploader :bg_image, ProfileUploader

  EMPLOYEE_RANGE = ['1-5', '6-15', '16-30', '30-50', '50+']
end
