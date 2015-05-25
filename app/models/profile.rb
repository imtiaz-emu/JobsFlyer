class Profile < ActiveRecord::Base

  # callbacks

  # associations
  belongs_to :user


  # validations
  validates_presence_of :first_name, :last_name, :phone
  # scopes

  # Constants

  # Instance methods


end
