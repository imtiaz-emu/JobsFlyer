class Profile < ActiveRecord::Base

  # callbacks

  # associations
  belongs_to :user

  # uploaders
  mount_uploader :photo, ProfileUploader

  # validations
  validates_presence_of :first_name, :last_name, :country
  # scopes

  # Constants

  # Instance methods
  def full_user_name
    self.first_name + ' ' + (self.last_name if self.last_name.present?)
  end

end
