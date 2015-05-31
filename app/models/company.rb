class Company < ActiveRecord::Base
  belongs_to :organization_category
  belongs_to :user

  mount_uploader :logo, ProfileUploader
  mount_uploader :bg_image, ProfileUploader
end
