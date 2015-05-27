class Profile < ActiveRecord::Base

  # callbacks

  # associations
  belongs_to :user

  # uploaders
  mount_uploader :photo, ProfileUploader

  # validations
  validates_presence_of :first_name, :last_name, :phone
  # scopes

  # Constants

  # Instance methods


end
